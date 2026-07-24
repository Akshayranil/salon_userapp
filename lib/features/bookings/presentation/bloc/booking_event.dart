part of 'booking_bloc.dart';

abstract class BookingEvent {}

class CreateBookingEvent extends BookingEvent {
  final BookingEntity booking;

  CreateBookingEvent(this.booking);
}

class GetUserBookingsEvent extends BookingEvent {
  final String userId;

  GetUserBookingsEvent(this.userId);
}
