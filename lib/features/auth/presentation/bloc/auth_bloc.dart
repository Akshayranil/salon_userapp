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
    on<SaveProfileEvent>(onSaveProfile);
    on<UploadProfileImageEvent>(onUploadImage);
    on<GetProfileEvent>(onGetProfile);
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

Future<void> onSaveProfile(
  SaveProfileEvent event,
  Emitter<AuthState> emit,
) async {
  emit(AuthLoading());
  try {
    await useCases.saveProfile(
      uid: event.uid,
      name: event.name,
      phone: event.phone,
      place: event.place,
      image: event.image,
    );

    emit(AuthProfileSaved());
  } catch (e) {
    emit(AuthFailure(e.toString()));
  }
}

Future<void> onUploadImage(
  UploadProfileImageEvent event,
  Emitter<AuthState> emit,
) async {
  emit(AuthLoading());
  try {
    final imageUrl =
        await useCases.uploadProfileImage(event.filePath);

    emit(ImageUploadedState(imageUrl));
  } catch (e) {
    emit(AuthFailure(e.toString()));
  }
}

Future<void> onGetProfile(
  GetProfileEvent event,
  Emitter<AuthState> emit,
) async {
  emit(AuthLoading());
  try {
    final uid = FirebaseAuth.instance.currentUser!.uid; // 🔥 GET UID HERE

    final data = await useCases.getProfile(uid);

    emit(ProfileLoaded(
      name: data.name ?? '',
      phone: data.phone ?? '',
      place: data.place ?? '',
      image: data.image ?? '',
    ));
  } catch (e) {
    emit(AuthFailure(e.toString()));
  }
}
}