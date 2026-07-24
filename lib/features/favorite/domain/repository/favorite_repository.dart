import 'package:salon_app/features/home/domain/entity/service_entity.dart';

abstract class FavoritesRepository {
  Future<void> addFavorite(String userId, ServiceEntity service);
  Future<void> removeFavorite(String userId, String serviceId);
  Future<List<ServiceEntity>> getFavorites(String userId);
}