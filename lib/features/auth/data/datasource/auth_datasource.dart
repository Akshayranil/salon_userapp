import 'package:salon_app/features/auth/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<void> signup(String email, String password);
  Future<void> logout();
  Future<bool> hasProfile(String uid);
  Future<UserModel> googleLogin();
}
