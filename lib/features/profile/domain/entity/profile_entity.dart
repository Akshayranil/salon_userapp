

class ProfileEntity {
  final String uid;
  final String email;
  final String? name;
  final String? phone;
  final String? place;
  final String? image;

  ProfileEntity({
    required this.uid,
    required this.email,
    this.name,
    this.phone,
    this.place,
    this.image,
  });
}