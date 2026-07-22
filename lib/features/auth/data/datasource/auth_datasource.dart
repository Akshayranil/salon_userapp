import 'package:salon_app/features/auth/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signup(String email, String password);
  Future<void> logout();
  Future<bool> hasProfile(String uid);
  Future<UserModel> googleLogin();
  Future<void> saveProfile({
    required String uid,
    required String name,
    required String phone,
    required String place,
    required String image,
  });
  Future<UserModel> getProfile(String uid);
  Future<String> uploadProfileImage(String filePath);
}
