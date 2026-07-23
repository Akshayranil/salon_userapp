import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:salon_app/features/auth/domain/entity/user_entity.dart';
import 'package:salon_app/features/auth/domain/usecase/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCases useCases;

  AuthBloc(this.useCases) : super(AuthInitial()) {
    on<AuthLogin>(onLogin);
    on<AuthSignUp>(onSignup);
    on<AuthLogout>(onLogout);
    on<GoogleLogin>(onGoogleLogin); 
    
  }

 Future<void> onLogin(AuthLogin event, Emitter<AuthState> emit) async {
  emit(AuthLoading());
  try {
    final user = await useCases.login(event.email, event.password);

    final hasProfile = await useCases.hasProfile(user.uid);

    emit(AuthSuccess(user, hasProfile));
  } catch (e) {
    emit(AuthFailure(e.toString()));
  }
}

  Future<void> onSignup(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await useCases.signup(event.email, event.password);
      emit(AuthSignedUp());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> onLogout(AuthLogout event, Emitter<AuthState> emit) async {
    await useCases.logout();
    emit(AuthInitial());
  }

  Future<void> onGoogleLogin(
  GoogleLogin event,
  Emitter<AuthState> emit,
) async {
  emit(AuthLoading());
  try {
    final user = await useCases.googleLogin();

    final hasProfile = await useCases.hasProfile(user.uid);

    emit(AuthSuccess(user, hasProfile));
  } catch (e) {
    emit(AuthFailure(e.toString()));
  }
}


}