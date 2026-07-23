import 'package:salon_app/features/bookings/domain/entity/booking_entity.dart';

abstract class BookingRepository {
  Future<void> createBooking(BookingEntity booking);
}