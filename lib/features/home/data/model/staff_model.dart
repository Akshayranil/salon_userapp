import 'package:salon_app/features/home/domain/entity/staff_entiy.dart';

class StaffModel extends StaffEntity {
  StaffModel({
    required super.id,
    required super.name,
    required super.image,
    required super.serviceIds,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json,String id) {
    return StaffModel(
      id: id,
      name: json['name'],
      image: json['image'],
      serviceIds: List<String>.from(json['serviceIds']),
    );
  }
}