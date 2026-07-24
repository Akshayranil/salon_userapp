import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salon_app/features/home/data/model/service_model.dart';

class FavoritesRemoteDataSource {
  final FirebaseFirestore firestore;

  FavoritesRemoteDataSource(this.firestore);

  Future<void> addFavorite(String userId, ServiceModel service) async {
    await firestore
        .collection("users")
        .doc(userId)
        .collection("favorites")
        .doc(service.id)
        .set({
      "name": service.name,
      "price": service.price,
      "image": service.image,
    });
  }

  Future<void> removeFavorite(String userId, String serviceId) async {
    await firestore
        .collection("users")
        .doc(userId)
        .collection("favorites")
        .doc(serviceId)
        .delete();
  }

  Future<List<ServiceModel>> getFavorites(String userId) async {
    final snapshot = await firestore
        .collection("users")
        .doc(userId)
        .collection("favorites")
        .get();

    return snapshot.docs
        .map((e) => ServiceModel.fromJson(e.data(), e.id))
        .toList();
  }
}