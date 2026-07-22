import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:salon_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:salon_app/features/auth/data/model/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl(this.auth, this.firestore);

  @override
  Future<UserModel> login(String email, String password) async {
    final result = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return UserModel.fromFirebase(result.user!);
  }

  @override
  Future<UserModel> signup(String email, String password) async {
    final result = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = result.user!;
    await firestore.collection('users').doc(user.uid).set({"email": email});
    return UserModel.fromFirebase(user);
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }

  // @override
  // Future<bool> hasProfile(String uid) async {
  //   final doc = await firestore.collection('users').doc(uid).get();
  //   return doc.exists;
  // }

  @override
Future<bool> hasProfile(String uid) async {
  final doc = await firestore.collection('users').doc(uid).get();

  if (!doc.exists) return false;

  final data = doc.data();

  // 🔥 REAL CHECK
  return data != null &&
      data['name'] != null &&
      data['name'].toString().isNotEmpty;
}

  @override
  Future<UserModel> googleLogin() async {
    final googleUser = await GoogleSignIn().signIn();

    final googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    final result = await auth.signInWithCredential(credential);

    final user = result.user!;

    return UserModel.fromFirebase(user);
  }

   @override
  Future<void> saveProfile({
    required String uid,
    required String name,
    required String phone,
    required String place,
    required String image,
  }) async {
    await firestore.collection('users').doc(uid).set({
      "name": name,
      "phone": phone,
      "place": place,
      "image": image,
    }, SetOptions(merge: true)); // ⚠️ IMPORTANT
  }

   @override
  Future<UserModel> getProfile(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();

    return UserModel.fromMap(uid, doc.data() ?? {});
  }

  @override
Future<String> uploadProfileImage(String filePath) async {
  final cloudName = "dbmzu0vdn";
  final uploadPreset = "user_image";

  final url = Uri.parse(
    "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
  );

  final request = http.MultipartRequest("POST", url);

  request.fields['upload_preset'] = uploadPreset;

  request.files.add(
    await http.MultipartFile.fromPath('file', filePath),
  );

  final response = await request.send();

  if (response.statusCode == 200) {
    final responseData = await response.stream.bytesToString();
    final jsonData = json.decode(responseData);

    return jsonData['secure_url']; // 🔥 THIS IS YOUR IMAGE URL
  } else {
    throw Exception("Image upload failed");
  }
}
}
