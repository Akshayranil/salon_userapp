import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FCMService {
  static Future<void> saveToken() async {
    final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    print("User not logged in yet");
    return;
  }
    final token = await FirebaseMessaging.instance.getToken();

    if (token == null) {
    print("FCM Token is null");
    return;
  }

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .set({
      "fcmToken": token,
    }, SetOptions(merge: true));
  }
}