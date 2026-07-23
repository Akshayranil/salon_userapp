part of 'profile_bloc.dart';

 class ProfileEvent {}

 class SaveProfileEvent extends ProfileEvent {
  final String uid;
  final String name;
  final String phone;
  final String place;
  final String image;

  SaveProfileEvent({
    required this.uid,
    required this.name,
    required this.phone,
    required this.place,
    required this.image,
  });
}

class UploadProfileImageEvent extends ProfileEvent {
  final String filePath;

  UploadProfileImageEvent(this.filePath);
}

class GetProfileEvent extends ProfileEvent {}
  