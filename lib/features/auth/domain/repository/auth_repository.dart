import 'package:salon_app/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> signup(String email, String password);
  Future<void> logout();
  Future<bool> hasProfile(String uid);
  Future<UserEntity> googleLogin();
  Future<void> saveProfile({
    required String uid,
    required String name,
    required String phone,
    required String place,
    required String image,
  });
  Future<UserEntity> getProfile(String uid);
  Future<String> uploadProfileImage(String filePath);
}
