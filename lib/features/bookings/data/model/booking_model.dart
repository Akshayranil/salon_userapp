import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entity/booking_entity.dart';

class BookingModel extends BookingEntity {
  BookingModel({
    required super.id,
    required super.serviceId,
    required super.serviceName,
    required super.staffId,
    required super.staffName,
    required super.userId,
    required super.amount,
    required super.date,
    required super.time,
    required super.status,
    required super.fcmToken
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "serviceId": serviceId,
      "serviceName": serviceName,
      "staffId": staffId,
      "staffName": staffName,
      "userId": userId,
      "amount": amount,
      "date": date,
      "time": time,
      "status": status,
      "createdAt": FieldValue.serverTimestamp(),
      "fcmToken":fcmToken
    };
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json["id"],
      serviceId: json["serviceId"],
      serviceName: json["serviceName"],
      staffId: json["staffId"],
      staffName: json["staffName"],
      userId: json["userId"],
      amount: (json["amount"] as num).toDouble(),
      date: json["date"],
      time: json["time"],
      status: json["status"],
      fcmToken: json["fcmToken"]??""
    );
  }

  factory BookingModel.fromEntity(BookingEntity entity) {
    return BookingModel(
      id: entity.id,
      serviceId: entity.serviceId,
      serviceName: entity.serviceName,
      staffId: entity.staffId,
      staffName: entity.staffName,
      userId: entity.userId,
      amount: entity.amount,
      date: entity.date,
      time: entity.time,
      status: entity.status,
      fcmToken: entity.fcmToken
    );
  }
}