// Import firebase scripts
importScripts("https://www.gstatic.com/firebasejs/9.6.11/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.6.11/firebase-messaging-compat.js");

// Firebase config - SENING PROYEKTDAN OLGAN CONFIG
firebase.initializeApp({
  apiKey: "AIzaSyExample-Your-Real-ApiKey",
  authDomain: "topildi-12345.firebaseapp.com",
  projectId: "topildi-12345",
  storageBucket: "topildi-12345.appspot.com",
  messagingSenderId: "323891530719",
  appId: "1:323891530719:web:abcd1234efgh5678",
  measurementId: "G-XXXXXXX"
});

// Messaging init
const messaging = firebase.messaging();

// Background xabarlar kelganda ko‘rsatish
messaging.onBackgroundMessage((payload) => {
  console.log("Push xabar keldi: ", payload);
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: "/icon.png"
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
