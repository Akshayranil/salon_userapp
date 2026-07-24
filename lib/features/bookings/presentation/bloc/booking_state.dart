part of 'booking_bloc.dart';

abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingSuccess extends BookingState {}

class BookingLoaded extends BookingState {
  final List<BookingEntity> bookings;

  BookingLoaded(this.bookings);
}

class BookingFailure extends BookingState {
  final String error;

  BookingFailure(this.error);
}
