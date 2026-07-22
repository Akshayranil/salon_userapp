// data/models/user_model.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:salon_app/features/auth/domain/entity/user_entity.dart';


class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    required super.email,
    super.name,
    super.phone,
    super.place,
    super.image,
  });

  factory UserModel.fromFirebase(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
    );
  }

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    return UserModel(
      uid: uid,
      email: map['email'] ?? '',
      name: map['name'],
      phone: map['phone'],
      place: map['place'],
      image: map['image'],
    );
  }

   Map<String, dynamic> toMap() {
    return {
      "email": email,
      "name": name,
      "phone": phone,
      "place": place,
      "image": image,
    };
  }
}