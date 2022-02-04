importScripts('https://www.gstatic.com/firebasejs/8.2.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.2.0/firebase-messaging.js');

// Initialize the Firebase app in the service worker by passing the generated config
var firebaseConfig = {
    apiKey: "AIzaSyA0OI6fBoVEpYoz5sFLq4053lOJddh_QlY",
    authDomain: "man-at-home-app.firebaseapp.com",
    projectId: "man-at-home-app",
    storageBucket: "man-at-home-app.appspot.com",
    messagingSenderId: "186478679631",
    appId: "1:186478679631:web:e29e82ce06b89441357c3a",
    measurementId: "G-HH5ZM1E6E5"
  };

firebase.initializeApp(firebaseConfig);

// Retrieve firebase messaging
const messaging = firebase.messaging();

messaging.onBackgroundMessage(function(payload) {
  console.log('Received background message ', payload);

  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
  };

  self.registration.showNotification(notificationTitle,
    notificationOptions);
});