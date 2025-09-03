// Firebase service worker push uchun
importScripts("https://www.gstatic.com/firebasejs/9.6.11/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.6.11/firebase-messaging-compat.js");

// Sening Firebase config
firebase.initializeApp({
  apiKey: "AIzaSyA39AFiKjNF3XO4NwkwzU1HA_5pKV9xEN4",
  authDomain: "topildi.firebaseapp.com",
  databaseURL: "https://topildi-default-rtdb.firebaseio.com",
  projectId: "topildi",
  storageBucket: "topildi.firebasestorage.app",
  messagingSenderId: "323891530719",
  appId: "1:323891530719:web:d57c2ce38781dc37e4926a",
  measurementId: "G-NKCMKCXZQ7"
});

// Messaging init
const messaging = firebase.messaging();

// Agar app backgroundda bo‘lsa, kelgan pushni ko‘rsatadi
messaging.onBackgroundMessage((payload) => {
  console.log("Push keldi:", payload);
  self.registration.showNotification(payload.notification.title, {
    body: payload.notification.body,
    icon: "/icon.png" // xohlasang bu yerni logoning rasmiga almashtirasan
  });
});
