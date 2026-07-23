import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salon_app/features/profile/data/datasource/profile_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:salon_app/features/profile/data/model/profile_model.dart';

class ProfileDatasorceimplementation implements ProfileRemoteDataSource {
  final FirebaseFirestore firestore;

  ProfileDatasorceimplementation({required this.firestore});
   
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
  Future<ProfileModel> getProfile(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();

    return ProfileModel.fromMap(uid, doc.data() ?? {});
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