import 'package:salon_app/features/profile/domain/entity/profile_entity.dart';
import 'package:salon_app/features/profile/domain/repository/profile_repository.dart';

class ProfileUseCases {
  final ProfileRepository repository;

  ProfileUseCases({required this.repository});

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

   Future<ProfileEntity> getProfile(String uid) {
    return repository.getProfile(uid);
  }

  Future<String> uploadProfileImage(String filePath) {
  return repository.uploadProfileImage(filePath);
}
}