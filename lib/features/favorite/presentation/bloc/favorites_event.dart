part of 'favorites_bloc.dart';

abstract class FavoritesEvent {}

class LoadFavoritesEvent extends FavoritesEvent {}

class ToggleFavoriteEvent extends FavoritesEvent {
  final ServiceEntity service;

  ToggleFavoriteEvent(this.service);
}
