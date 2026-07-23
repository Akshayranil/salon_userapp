import 'package:salon_app/features/profile/domain/entity/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.uid,
    required super.email,
    super.name,
    super.phone,
    super.place,
    super.image,
  });

 

  factory ProfileModel.fromMap(String uid, Map<String, dynamic> map) {
    return ProfileModel(
      uid: uid,
      email: map['email'] ?? '',
      name: map['name'],
      phone: map['phone'],
      place: map['place'],
      image: map['image'],
    );
  }

   Map<String, dynamic> toMap() {
    return {
      "email": email,
      "name": name,
      "phone": phone,
      "place": place,
      "image": image,
    };
  }
}