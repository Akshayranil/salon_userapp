import 'package:salon_app/features/home/domain/entity/service_entity.dart';
import 'package:salon_app/features/home/domain/entity/staff_entiy.dart';
import 'package:salon_app/features/home/domain/repository/service_userrepository.dart';

class GetServices {
  final ServiceUserRepository repo;
  GetServices(this.repo);

  Future<List<ServiceEntity>> call() => repo.getServices();
}

class GetStaffByService {
  final ServiceUserRepository repo;
  GetStaffByService(this.repo);

  Future<List<StaffEntity>> call(String serviceId) =>
      repo.getStaffByService(serviceId);
}