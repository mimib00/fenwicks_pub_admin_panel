importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-app.js");
importScripts(
  "https://www.gstatic.com/firebasejs/7.15.5/firebase-messaging.js"
);

//Using singleton breaks instantiating messaging()
// App firebase = FirebaseWeb.instance.app;

firebase.initializeApp({
  apiKey: "AIzaSyB6rOQS7jZhVWmf77moXzv2Lj9Y-si0T28",
  authDomain: "fenwicks-pub.firebaseapp.com",
  projectId: "fenwicks-pub",
  storageBucket: "fenwicks-pub.appspot.com",
  messagingSenderId: "968413471908",
  appId: "1:968413471908:web:71502288e3cc8deea27231",
  measurementId: "G-6HF95T836J",
});

const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
  const promiseChain = clients
    .matchAll({
      type: "window",
      includeUncontrolled: true,
    })
    .then((windowClients) => {
      for (let i = 0; i < windowClients.length; i++) {
        const windowClient = windowClients[i];
        windowClient.postMessage(payload);
      }
    })
    .then(() => {
      return registration.showNotification("New Message");
    });
  return promiseChain;
});
self.addEventListener("notificationclick", function (event) {
  console.log("notification received: ", event);
});
