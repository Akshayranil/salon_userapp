import 'package:salon_app/features/auth/domain/entity/user_entity.dart';
import 'package:salon_app/features/auth/domain/repository/auth_repository.dart';

class AuthUseCases {
  final AuthRepository repository;

  AuthUseCases(this.repository);

  Future<UserEntity> login(String email, String password) {
    return repository.login(email, password);
  }

  Future<void> signup(String email, String password) {
    return repository.signup(email, password);
  }

  Future<void> logout() {
    return repository.logout();
  }

  Future<bool> hasProfile(String uid) {
    return repository.hasProfile(uid);
  }

  Future<UserEntity> googleLogin() {
    return repository.googleLogin();
  }

  Future<void> saveProfile({
    required String uid,
    required String name,
    required String phone,
    required String place,
    required String image,
  }) {
    return repository.saveProfile(
      uid: uid,
      name: name,
      phone: phone,
      place: place,
      image: image,
    );
  }

   Future<UserEntity> getProfile(String uid) {
    return repository.getProfile(uid);
  }

  Future<String> uploadProfileImage(String filePath) {
  return repository.uploadProfileImage(filePath);
}
}
