import '../../domain/entity/booking_entity.dart';

class BookingModel extends BookingEntity {
  BookingModel({
    required super.id,
    required super.serviceId,
    required super.staffId,
    required super.amount,
    required super.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "serviceId": serviceId,
      "staffId": staffId,
      "amount": amount,
      "status": status,
    };
  }

  factory BookingModel.fromEntity(BookingEntity entity) {
    return BookingModel(
      id: entity.id,
      serviceId: entity.serviceId,
      staffId: entity.staffId,
      amount: entity.amount,
      status: entity.status,
    );
  }
}