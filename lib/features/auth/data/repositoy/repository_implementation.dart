import 'package:salon_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:salon_app/features/auth/data/model/user_model.dart';
import 'package:salon_app/features/auth/domain/entity/user_entity.dart';
import 'package:salon_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<UserEntity> login(String email, String password) async {
    final model = await remote.login(email, password);
    return model; // since model extends entity
  }

  @override
  Future<UserEntity> signup(String email, String password) {
    return remote.signup(email, password);
  }

  @override
  Future<void> logout() {
    return remote.logout();
  }

  @override
  Future<bool> hasProfile(String uid) {
    return remote.hasProfile(uid);
  }

  @override
  Future<UserModel> googleLogin() async {
  final model = await remote.googleLogin();
  return model; // model extends UserEntity
}

 
}
