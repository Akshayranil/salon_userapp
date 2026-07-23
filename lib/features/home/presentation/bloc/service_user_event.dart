part of 'service_user_bloc.dart';

abstract class ServiceUserEvent {}

class LoadServicesEvent extends ServiceUserEvent {}

class LoadStaffByServiceEvent extends ServiceUserEvent {
  final String serviceId;
  LoadStaffByServiceEvent(this.serviceId);
}


