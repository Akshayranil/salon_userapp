part of 'service_user_bloc.dart';

abstract class ServiceUserState {}

class ServiceInitial extends ServiceUserState {}

class ServiceLoading extends ServiceUserState {}

class ServicesLoaded extends ServiceUserState {
  final List<ServiceEntity> services;
  ServicesLoaded(this.services);
}

class StaffLoaded extends ServiceUserState {
  final List<StaffEntity> staff;
  StaffLoaded(this.staff);
}
