import 'package:salon_app/features/home/domain/entity/service_entity.dart';

class ServiceModel extends ServiceEntity {
  ServiceModel({
    required super.id,
    required super.name,
    required super.price,
    required super.image,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
    );
  }
}