import 'package:salon_app/features/favorite/data/datasource/favorite_datasource.dart';
import 'package:salon_app/features/favorite/domain/repository/favorite_repository.dart';
import 'package:salon_app/features/home/data/model/service_model.dart';
import 'package:salon_app/features/home/domain/entity/service_entity.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource remote;

  FavoritesRepositoryImpl(this.remote);

  @override
  Future<void> addFavorite(String userId, ServiceEntity service) {
    return remote.addFavorite(
      userId,
      ServiceModel(
        id: service.id,
        name: service.name,
        price: service.price,
        image: service.image,
      ),
    );
  }

  @override
  Future<void> removeFavorite(String userId, String serviceId) {
    return remote.removeFavorite(userId, serviceId);
  }

  @override
  Future<List<ServiceEntity>> getFavorites(String userId) {
    return remote.getFavorites(userId);
  }
}