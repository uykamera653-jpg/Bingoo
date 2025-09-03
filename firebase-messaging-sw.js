// Service Worker (push xabarlarni fon rejimida olish uchun)

// Firebase kutubxonalarini import qilamiz
importScripts("https://www.gstatic.com/firebasejs/10.12.2/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.12.2/firebase-messaging-compat.js");

// ✅ Firebase config – SENING loyihang "Topildi"
firebase.initializeApp({
  apiKey: "AIzaSyD4-EXAMPLE-KEY-FAKExxxxx",   // bu joyni Firebase → Project Settings → General dan olasan
  authDomain: "topildi.firebaseapp.com",
  projectId: "topildi",
  storageBucket: "topildi.appspot.com",
  messagingSenderId: "323891530719",
  appId: "1:323891530719:web:abc123def456ghi789"
});

// Messagingni ishga tushiramiz
const messaging = firebase.messaging();

// Push xabarni ushlab olish
messaging.onBackgroundMessage(function(payload) {
  console.log("📩 Push keldi (background): ", payload);

  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: "/icon-192.png"  // ikonka
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
