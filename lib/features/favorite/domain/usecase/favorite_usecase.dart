import 'package:salon_app/features/favorite/domain/repository/favorite_repository.dart';
import 'package:salon_app/features/home/domain/entity/service_entity.dart';

class FavoritesUseCase {
  final FavoritesRepository repo;

  FavoritesUseCase(this.repo);

  Future<List<ServiceEntity>> getFavorites(String userId) {
    return repo.getFavorites(userId);
  }

  Future<void> toggleFavorite(
    String userId,
    ServiceEntity service,
    List<ServiceEntity> currentFavorites,
  ) async {
    final isFav =
        currentFavorites.any((e) => e.id == service.id);

    if (isFav) {
      await repo.removeFavorite(userId, service.id);
    } else {
      await repo.addFavorite(userId, service);
    }
  }
}