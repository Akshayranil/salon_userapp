import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:salon_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:salon_app/features/auth/data/model/user_model.dart';


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

 
}
