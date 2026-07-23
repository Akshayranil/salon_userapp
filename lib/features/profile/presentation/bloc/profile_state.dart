part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSaved extends ProfileState {}

class ImageUploadedState extends ProfileState {
  final String imageUrl;

  const ImageUploadedState(this.imageUrl);

  @override
  List<Object> get props => [imageUrl];
}

class ProfileLoaded extends ProfileState {
  final String name;
  final String phone;
  final String place;
  final String image;

  const ProfileLoaded({
    required this.name,
    required this.phone,
    required this.place,
    required this.image,
  });

  @override
  List<Object> get props => [name, phone, place, image];
}

class ProfileFailure extends ProfileState {
  final String error;
  const ProfileFailure(this.error);
  @override
 
  List<Object> get props => [error];
}