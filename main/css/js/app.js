/* main/js/app.js — Asosiy funksiyalar */
import { initializeApp } from "https://www.gstatic.com/firebasejs/10.12.2/firebase-app.js";
import { getFirestore, collection, addDoc, getDocs, deleteDoc, doc } from "https://www.gstatic.com/firebasejs/10.12.2/firebase-firestore.js";

/* Firebase sozlamalari — o‘zingizni config bilan almashtiring */
const firebaseConfig = {
  apiKey: "AIzaSyA39AFiKjNF3XO4NwkwzU1HA_5pKV9xEN4",
  authDomain: "topildi.firebaseapp.com",
  projectId: "topildi",
  storageBucket: "topildi.appspot.com",
  messagingSenderId: "323891530719",
  appId: "1:323891530719:web:d57c2ce38781dc37e4926a"
};

const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

/* E’lon qo‘shish */
export async function addAd(type, title, city, reward, user){
  await addDoc(collection(db,"ads"),{
    type, title, city, reward, user,
    createdAt: Date.now()
  });
}

/* E’lonlarni olish */
export async function getAds(){
  const q = await getDocs(collection(db,"ads"));
  let res = [];
  q.forEach(d => res.push({...d.data(), id:d.id}));
  return res;
}

/* E’lonni o‘chirish */
export async function deleteAd(id){
  await deleteDoc(doc(db,"ads",id));
}
