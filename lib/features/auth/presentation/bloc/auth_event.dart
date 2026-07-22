part of 'auth_bloc.dart';

@immutable
class AuthEvent {}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin(this.email, this.password);
}

class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  AuthSignUp(this.email, this.password);
}

class AuthLogout extends AuthEvent {}

class GoogleLogin extends AuthEvent {}

class SaveProfileEvent extends AuthEvent {
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

class UploadProfileImageEvent extends AuthEvent {
  final String filePath;

  UploadProfileImageEvent(this.filePath);
}

class GetProfileEvent extends AuthEvent {}