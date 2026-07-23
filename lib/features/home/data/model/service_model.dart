import 'package:salon_app/features/home/domain/entity/service_entity.dart';

class ServiceModel extends ServiceEntity {
  ServiceModel({
    required super.id,
    required super.name,
    required super.price,
    required super.image,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json,String id) {
    return ServiceModel(
      id: id,
      name: json['name']??"Leonel Messi",
      price: (json['price'] as num).toDouble(),
      image: json['image']??"Not found",
    );
  }
}