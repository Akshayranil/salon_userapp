part of 'auth_bloc.dart';

@immutable
class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;
  final bool hasProfile;

  AuthSuccess(this.user, this.hasProfile);

  @override
  List<Object?> get props => [user, hasProfile];
}


class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
  @override
 
  List<Object?> get props => [error];
}

class AuthSignedUp extends AuthState {}

class AuthProfileSaved extends AuthState {}

class ImageUploadedState extends AuthState {
  final String imageUrl;

  ImageUploadedState(this.imageUrl);

  @override
  List<Object?> get props => [imageUrl];
}

class ProfileLoaded extends AuthState {
  final String name;
  final String phone;
  final String place;
  final String image;

  ProfileLoaded({
    required this.name,
    required this.phone,
    required this.place,
    required this.image,
  });

  @override
  List<Object?> get props => [name, phone, place, image];
}
