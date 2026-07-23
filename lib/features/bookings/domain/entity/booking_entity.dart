class BookingEntity {
  final String id;
  final String serviceId;
  final String staffId;
  final double amount;
  final String status;

  BookingEntity({
    required this.id,
    required this.serviceId,
    required this.staffId,
    required this.amount,
    required this.status,
  });
}