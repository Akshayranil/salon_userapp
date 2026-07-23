import 'package:salon_app/features/home/domain/entity/service_entity.dart';
import 'package:salon_app/features/home/domain/entity/staff_entiy.dart';

abstract class ServiceUserRepository {
  Future<List<ServiceEntity>> getServices();
  Future<List<StaffEntity>> getStaffByService(String serviceId);
}