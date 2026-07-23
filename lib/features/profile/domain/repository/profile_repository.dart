import 'package:salon_app/features/profile/domain/entity/profile_entity.dart';

abstract class ProfileRepository {
   Future<void> saveProfile({
    required String uid,
    required String name,
    required String phone,
    required String place,
    required String image,
  });
  Future<ProfileEntity> getProfile(String uid);
  Future<String> uploadProfileImage(String filePath);
}