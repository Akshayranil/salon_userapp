class StaffEntity {
  final String id;
  final String name;
  final String image;
  final List<String> serviceIds;

  StaffEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.serviceIds,
  });
}