importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js");

firebase.initializeApp({
    apiKey: "AIzaSyAQaiyomtr_f-4tbBotvGi6T7tCs1OzrIo",
    authDomain: "flybuy-rnlab.firebaseapp.com",
    databaseURL: "https://flybuy-rnlab.firebaseio.com",
    projectId: "flybuy-rnlab",
    storageBucket: "flybuy-rnlab.appspot.com",
    messagingSenderId: "295269595518",
    appId: "1:295269595518:web:9e19ff9142d25651095b2f",
    measurementId: "G-0MNTSB8L2C"
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});
