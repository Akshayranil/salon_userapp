// data/models/user_model.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:salon_app/features/auth/domain/entity/user_entity.dart';


class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    required super.email,
  });

  factory UserModel.fromFirebase(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
    );
  }
}