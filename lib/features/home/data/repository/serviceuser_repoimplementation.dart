import 'package:salon_app/features/home/data/datasource/serviceuser_datasource.dart';
import 'package:salon_app/features/home/domain/entity/service_entity.dart';
import 'package:salon_app/features/home/domain/entity/staff_entiy.dart';
import 'package:salon_app/features/home/domain/repository/service_userrepository.dart';

class ServiceUserRepositoryImpl implements ServiceUserRepository {
  final ServiceUserRemoteDataSource remote;

  ServiceUserRepositoryImpl(this.remote);

  @override
  Future<List<ServiceEntity>> getServices() {
    return remote.getServices();
  }

  @override
  Future<List<StaffEntity>> getStaffByService(String serviceId) {
    return remote.getStaffByService(serviceId);
  }
}