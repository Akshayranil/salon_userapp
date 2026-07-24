class BookingEntity {
  final String id;
  final String serviceId;
  final String serviceName;
  final String staffId;
  final String staffName;
  final String userId;
  final double amount;
  final String date;
  final String time;
  final String status;
  final String fcmToken;

  BookingEntity({
    required this.id,
    required this.serviceId,
    required this.serviceName,
    required this.staffId,
    required this.staffName,
    required this.userId,
    required this.amount,
    required this.date,
    required this.time,
    required this.status,
    required this.fcmToken
  });
}
