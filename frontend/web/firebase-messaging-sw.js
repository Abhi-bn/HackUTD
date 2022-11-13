importScripts("https://www.gstatic.com/firebasejs/9.9.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.9.0/firebase-messaging-compat.js");

/*Update with yours config*/
const firebaseConfig = {
    apiKey: "AIzaSyBl1PDuHJ7AI3Iz3NCNzELJJkr3ZkAANIw",
    authDomain: "hackutd-helpy.firebaseapp.com",
    projectId: "hackutd-helpy",
    storageBucket: "hackutd-helpy.appspot.com",
    messagingSenderId: "398798666646",
    appId: "1:398798666646:web:a1559e8dca7b8385bdfbb7"
};
firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();

/*messaging.onMessage((payload) => {
console.log('Message received. ', payload);*/
messaging.onBackgroundMessage(function (payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
        body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
        notificationOptions);
});