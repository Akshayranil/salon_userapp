const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendBookingNotification = functions.firestore
  .document("bookings/{bookingId}")
  .onCreate(async (snap, context) => {
    const data = snap.data();

    // 🔥 GET USER TOKEN FROM USERS COLLECTION
    const userDoc = await admin.firestore()
      .collection("users")
      .doc(data.userId)
      .get();

    const fcmToken = userDoc.data()?.fcmToken;

    if (!fcmToken) {
      console.log("No FCM token found");
      return;
    }

    const message = {
      token: fcmToken,
      notification: {
        title: "Booking Confirmed",
        body: `Your ${data.serviceName} is booked at ${data.time}`,
      },
    };

    await admin.messaging().send(message);
  });