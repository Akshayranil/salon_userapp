import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salon_app/features/home/domain/entity/service_entity.dart';
import 'package:salon_app/features/home/domain/entity/staff_entiy.dart';
import 'package:salon_app/features/home/domain/usecase/serviceuser_usecase.dart';

part 'service_user_event.dart';
part 'service_user_state.dart';

class ServiceUserBloc extends Bloc<ServiceUserEvent, ServiceUserState> {
  final GetServices getServices;
  final GetStaffByService getStaff;

  ServiceUserBloc(this.getServices, this.getStaff)
      : super(ServiceInitial()) {
    on<LoadServicesEvent>((event, emit) async {
      emit(ServiceLoading());
      final data = await getServices();
      emit(ServicesLoaded(data));
    });

    on<LoadStaffByServiceEvent>((event, emit) async {
      emit(ServiceLoading());
      final data = await getStaff(event.serviceId);
      emit(StaffLoaded(data));
    });
  }
}