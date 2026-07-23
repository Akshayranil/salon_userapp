import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salon_app/features/profile/domain/usecase/profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUseCases useCases;

  ProfileBloc(this.useCases) : super(ProfileInitial()) {
    on<SaveProfileEvent>(onSaveProfile);
    on<UploadProfileImageEvent>(onUploadImage);
    on<GetProfileEvent>(onGetProfile);
  }

  Future<void> onSaveProfile(
  SaveProfileEvent event,
  Emitter<ProfileState> emit,
) async {
  emit(ProfileLoading());
  try {
    await useCases.saveProfile(
      uid: event.uid,
      name: event.name,
      phone: event.phone,
      place: event.place,
      image: event.image,
    );

    emit(ProfileSaved());
  } catch (e) {
    emit(ProfileFailure(e.toString()));
  }
}

Future<void> onUploadImage(
  UploadProfileImageEvent event,
  Emitter<ProfileState> emit,
) async {
  emit(ProfileLoading());
  try {
    final imageUrl =
        await useCases.uploadProfileImage(event.filePath);

    emit(ImageUploadedState(imageUrl));
  } catch (e) {
    emit(ProfileFailure(e.toString()));
  }
}

Future<void> onGetProfile(
  GetProfileEvent event,
  Emitter<ProfileState> emit,
) async {
  emit(ProfileLoading());
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
    emit(ProfileFailure(e.toString()));
  }
}
}
