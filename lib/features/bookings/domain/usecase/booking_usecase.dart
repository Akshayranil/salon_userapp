import 'package:salon_app/features/bookings/domain/entity/booking_entity.dart';
import 'package:salon_app/features/bookings/domain/repository/booking_repository.dart';

class BookingUsecase {
  final BookingRepository repository;

  BookingUsecase(this.repository);

  Future<void> create(BookingEntity booking) {
    return repository.createBooking(booking);
  }

  Future<List<BookingEntity>> getUserBookings(String userId) {
    return repository.getUserBookings(userId);
  }
}