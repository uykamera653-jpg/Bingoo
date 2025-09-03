/* js/app.js — Asosiy ilova logikasi (Firebase + real-time e’lonlar) */
import { initializeApp } from "https://www.gstatic.com/firebasejs/10.12.5/firebase-app.js";
import { getAuth, GoogleAuthProvider, signInWithPopup, onAuthStateChanged, signOut } from "https://www.gstatic.com/firebasejs/10.12.5/firebase-auth.js";
import {
  getFirestore, collection, doc, getDoc, addDoc, deleteDoc, updateDoc,
  serverTimestamp, onSnapshot, query, orderBy, where
} from "https://www.gstatic.com/firebasejs/10.12.5/firebase-firestore.js";

/* === 1) Firebase config — sizniki bilan to‘ldirilgan === */
const firebaseConfig = {
  apiKey: "AIzaSyA39AFiKjNF3XO4NwkwzU1HA_5pKV9xEN4",
  authDomain: "topildi.firebaseapp.com",
  databaseURL: "https://topildi-default-rtdb.firebaseio.com",
  projectId: "topildi",
  storageBucket: "topildi.firebasestorage.app",
  messagingSenderId: "323891530719",
  appId: "1:323891530719:web:d57c2ce38781dc37e4926a",
  measurementId: "G-NKCMKCXZQ7"
};

/* === 2) Init === */
const app = initializeApp(firebaseConfig);
const auth = getAuth(app);
const db = getFirestore(app);

/* === 3) DOM qisqa helperlar === */
const $ = (sel, root=document) => root.querySelector(sel);
const $$ = (sel, root=document) => [...root.querySelectorAll(sel)];
const listEl = $("#elon-list");       // index.html da <div id="elon-list"></div> bo‘lishi kerak
const loginBtn = $("#btn-login");     // ixtiyoriy tugmalar (bo‘lmasa ham xato bermaydi)
const logoutBtn = $("#btn-logout");
const newForm = $("#form-new");       // yangi e’lon formasi (bo‘lmasa ham mayli)
const filterSel = $("#filter");       // <select id="filter"> Hammasi|Yo'qotdim|Topdim

/* === 4) Admin tekshiruv === */
async function isAdmin(uid) {
  if (!uid) return false;
  try {
    const dref = doc(db, "rules", uid);
    const snap = await getDoc(dref);
    return snap.exists() && !!snap.data().admin;
  } catch (e) {
    console.warn("Admin check error:", e);
    return false;
  }
}

/* === 5) Render === */
function elonCardView(id, data, canDelete=false) {
  const created = data.createdAt?.toDate ? data.createdAt.toDate() : null;
  const time = created ? created.toLocaleString() : "—";
  const userLine = data.userEmail ? ` (${data.userEmail})` : "";
  const badge = data.type === "topdim" ? "✅" : "❗";

  return `
    <article class="card">
      <div class="card-head">
        <span class="badge">${badge}</span>
        <h3 class="title">${escapeHtml(data.title || "Narsa")}</h3>
      </div>
      <div class="card-body">
        <div><b>Shahar:</b> ${escapeHtml(data.city || "—")}</div>
        <div><b>Telefon:</b> ${escapeHtml(data.phone || "—")}</div>
        <div><b>Izoh:</b> ${escapeHtml(data.desc || "—")}</div>
        <div class="muted"><b>Joylagan:</b> ${escapeHtml(data.userName || "Noma'lum")}${escapeHtml(userLine)} • ${time}</div>
      </div>
      <div class="card-foot">
        ${canDelete ? `<button class="btn btn-danger" data-del="${id}">🗑 O‘chirish</button>` : ""}
      </div>
    </article>
  `;
}
function renderEmpty(msg="Hozircha e’lonlar yo‘q.") {
  listEl.innerHTML = `<div class="empty">${msg}</div>`;
}
function escapeHtml(s) {
  return String(s ?? "")
    .replaceAll("&","&amp;").replaceAll("<","&lt;")
    .replaceAll(">","&gt;").replaceAll('"',"&quot;").replaceAll("'","&#39;");
}

/* === 6) Real-time e’lonlarni yuklash === */
let unsub = null;
async function loadElonlar() {
  if (!listEl) return;

  const f = (filterSel?.value || "all").toLowerCase();
  let qRef = query(collection(db, "Elonlar"), orderBy("createdAt", "desc"));
  if (f === "topdim") qRef = query(collection(db, "Elonlar"), where("type","==","topdim"), orderBy("createdAt","desc"));
  if (f === "yoqotdim") qRef = query(collection(db, "Elonlar"), where("type","==","yoqotdim"), orderBy("createdAt","desc"));

  if (unsub) unsub(); // eski listenerni yopish
  listEl.innerHTML = `<div class="loading">Yuklanmoqda…</div>`;

  const user = auth.currentUser;
  const admin = await isAdmin(user?.uid);

  unsub = onSnapshot(qRef, (snap) => {
    if (snap.empty) return renderEmpty();
    const html = snap.docs.map(d => elonCardView(d.id, d.data(), admin)).join("");
    listEl.innerHTML = html;
  }, (err) => {
    console.error(err);
    renderEmpty("Xatolik: ma’lumotlarni yuklab bo‘lmadi.");
  });
}

/* === 7) Auth UI === */
loginBtn?.addEventListener("click", async () => {
  const provider = new GoogleAuthProvider();
  await signInWithPopup(auth, provider);
});
logoutBtn?.addEventListener("click", () => signOut(auth));

onAuthStateChanged(auth, async (user) => {
  document.body.classList.toggle("authed", !!user);
  await loadElonlar();
});

/* === 8) Filtr o‘zgarsa qayta yuklash === */
filterSel?.addEventListener("change", loadElonlar);

/* === 9) Yangi e’lon yuborish (ixtiyoriy forma bo‘lsa) === */
newForm?.addEventListener("submit", async (e) => {
  e.preventDefault();
  const fd = new FormData(newForm);
  const user = auth.currentUser;

  const data = {
    title: fd.get("title")?.toString().trim() || "",
    city:  fd.get("city")?.toString().trim() || "",
    phone: fd.get("phone")?.toString().trim() || "",
    desc:  fd.get("desc")?.toString().trim() || "",
    type:  (fd.get("type") || "yoqotdim").toString(), // 'yoqotdim' | 'topdim'
    userId:  user?.uid || null,
    userEmail: user?.email || null,
    userName:  user?.displayName || null,
    createdAt: serverTimestamp()
  };

  try {
    await addDoc(collection(db, "Elonlar"), data);
    newForm.reset();
    alert("E’lon joylandi!");
  } catch (e) {
    console.error(e);
    alert("Xatolik: e’lonni joylab bo‘lmadi.");
  }
});

/* === 10) O‘chirish (faqat admin) === */
document.addEventListener("click", async (e) => {
  const btn = e.target.closest("[data-del]");
  if (!btn) return;

  const id = btn.getAttribute("data-del");
  const user = auth.currentUser;
  if (!await isAdmin(user?.uid)) {
    alert("Faqat admin o‘chira oladi.");
    return;
  }
  if (!confirm("Rostdan ham o‘chirilsinmi?")) return;

  try {
    await deleteDoc(doc(db, "Elonlar", id));
  } catch (e) {
    console.error(e);
    alert("Xatolik: o‘chirish muvaffaqiyatsiz.");
  }
});

/* === 11) Start === */
loadElonlar();
