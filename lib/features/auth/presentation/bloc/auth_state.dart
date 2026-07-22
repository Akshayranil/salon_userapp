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
