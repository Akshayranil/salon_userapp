import 'package:salon_app/features/profile/data/model/profile_model.dart';

abstract class ProfileRemoteDataSource{
  Future<void> saveProfile({
    required String uid,
    required String name,
    required String phone,
    required String place,
    required String image,
  });
  Future<ProfileModel> getProfile(String uid);
  Future<String> uploadProfileImage(String filePath);
}