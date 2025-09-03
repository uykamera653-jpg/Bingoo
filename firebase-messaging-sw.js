// Import firebase scripts
importScripts("https://www.gstatic.com/firebasejs/9.6.11/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.6.11/firebase-messaging-compat.js");

// Firebase config - SENING PROYEKTDAN
firebase.initializeApp({
  apiKey: "BBkV8yPd5KljuhBQxa3JQxKyZ5TWKORCIfEVuC1Lx6pZ147IMYq215LxxxunmeVK84La7dMFILUa7Cr4cIVui1A",
  authDomain: "topildi.firebaseapp.com",
  projectId: "topildi",
  storageBucket: "topildi.appspot.com",
  messagingSenderId: "323891530719",
  appId: "1:323891530719:web:xxxxxxxxxxxxxxx"
});

// Messaging init
const messaging = firebase.messaging();

// Background xabarlar kelganda chiqarish
messaging.onBackgroundMessage((payload) => {
  console.log("Push xabar keldi: ", payload);

  const notificationTitle = payload.notification?.title || "Yangi xabar";
  const notificationOptions = {
    body: payload.notification?.body || "Sizga yangi bildirishnoma keldi",
    icon: "/icon.png"
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
