// FCM (Firebase Cloud Messaging) uchun frontend kod

import { initializeApp } from "https://www.gstatic.com/firebasejs/10.12.2/firebase-app.js";
import { getMessaging, getToken, onMessage } from "https://www.gstatic.com/firebasejs/10.12.2/firebase-messaging.js";

// ✅ Firebase config – SENING loyihang "Topildi"
const firebaseConfig = {
  apiKey: "AIzaSyD4-EXAMPLE-KEY-FAKExxxxx",   // bu joyni Firebase → Project Settings → General dan olasan
  authDomain: "topildi.firebaseapp.com",
  projectId: "topildi",
  storageBucket: "topildi.appspot.com",
  messagingSenderId: "323891530719",
  appId: "1:323891530719:web:abc123def456ghi789"
};

// Firebase ilovasini ishga tushirish
const app = initializeApp(firebaseConfig);
const messaging = getMessaging(app);

// Token olish
getToken(messaging, {
  vapidKey: "BBkV8yPd5KljuhBQxa3JQxKyZ5TWKORCIfEVuC1Lx6pZ147IMYq215LxxxunmeVK84La7dMFILUa7Cr4cIVui1A"
})
  .then((currentToken) => {
    if (currentToken) {
      console.log("✅ Token olindi:", currentToken);
      // 👉 Agar xohlasang tokenni bazaga yoki backendga yuborasan
    } else {
      console.warn("⚠️ Token yo‘q (ruxsat olinmagan)");
    }
  })
  .catch((err) => {
    console.error("❌ Token olishda xato:", err);
  });

// Ochiq holda xabar olish
onMessage(messaging, (payload) => {
  console.log("📩 Xabar keldi (foreground): ", payload);
  alert("🔔 " + payload.notification.title + "\n" + payload.notification.body);
});
