import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salon_app/features/favorite/domain/usecase/favorite_usecase.dart';
import 'package:salon_app/features/home/domain/entity/service_entity.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesUseCase useCase;

  List<ServiceEntity> favorites = [];

  FavoritesBloc(this.useCase) : super(FavoritesInitial()) {

    on<LoadFavoritesEvent>((event, emit) async {
      emit(FavoritesLoading());
      try {
        final userId = FirebaseAuth.instance.currentUser!.uid;

        final data = await useCase.getFavorites(userId);
        favorites = data;

        emit(FavoritesLoaded(data));
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    });

    on<ToggleFavoriteEvent>((event, emit) async {
      try {
        final userId = FirebaseAuth.instance.currentUser!.uid;

        await useCase.toggleFavorite(
          userId,
          event.service,
          favorites,
        );

        final updated = await useCase.getFavorites(userId);
        favorites = updated;

        emit(FavoritesLoaded(updated));
      } catch (e) {
        emit(FavoritesError(e.toString()));
      }
    });
  }
}