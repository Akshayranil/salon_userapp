import 'package:salon_app/features/profile/data/datasource/profile_datasource.dart';
import 'package:salon_app/features/profile/domain/entity/profile_entity.dart';
import 'package:salon_app/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository{
  final ProfileRemoteDataSource remote;

  ProfileRepositoryImpl({required this.remote});

  @override
  Future<void> saveProfile({
    required String uid,
    required String name,
    required String phone,
    required String place,
    required String image,
  }) {
    return remote.saveProfile(
      uid: uid,
      name: name,
      phone: phone,
      place: place,
      image: image,
    );
  }

   @override
     Future<ProfileEntity> getProfile(String uid) async {
    final model = await remote.getProfile(uid);
    return model;
  }
  @override
  Future<String> uploadProfileImage(String filePath) {
  return remote.uploadProfileImage(filePath);
}
}