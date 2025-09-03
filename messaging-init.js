// Import Firebase app va messaging
import { initializeApp } from "https://www.gstatic.com/firebasejs/10.12.2/firebase-app.js";
import { getMessaging, getToken, onMessage } from "https://www.gstatic.com/firebasejs/10.12.2/firebase-messaging.js";

// ⚡ Shu yerga o'zingning Firebase config ma'lumotlaringni qo'yasan
const firebaseConfig = {
  apiKey: "AIzaSy.....",            // SENING API KEY
  authDomain: "topildi.firebaseapp.com",
  projectId: "topildi",
  storageBucket: "topildi.appspot.com",
  messagingSenderId: "323891530719",
  appId: "1:323891530719:web:xxxxxx"
};

// Firebase init
const app = initializeApp(firebaseConfig);

// Messaging init
const messaging = getMessaging(app);

// Token olish (foydalanuvchi rozilik berganda)
getToken(messaging, { vapidKey: "BBkV8yPd5KljuhBQxa3JQxKyZ5TWKORCIfEVuC1Lx6pZ147IMYq215LxxxunmeVK84La7dMFILUa7Cr4cIVui1A" })
  .then((currentToken) => {
    if (currentToken) {
      console.log("🔑 Token:", currentToken);
      // Hohlasang bu tokenni bazaga yuborib saqlaysan
    } else {
      console.log("❌ Token olinmadi, ruxsat berilmagan.");
    }
  })
  .catch((err) => {
    console.error("Token olishda xatolik:", err);
  });

// Xabarlarni olish (app ochiq bo'lsa)
onMessage(messaging, (payload) => {
  console.log("📩 Yangi bildirishnoma:", payload);
  alert("📢 " + payload.notification.title + " - " + payload.notification.body);
});
