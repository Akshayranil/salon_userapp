import 'package:salon_app/features/bookings/data/datasource/booking_datasource.dart';
import 'package:salon_app/features/bookings/data/model/booking_model.dart';
import 'package:salon_app/features/bookings/domain/entity/booking_entity.dart';
import 'package:salon_app/features/bookings/domain/repository/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remote;

  BookingRepositoryImpl(this.remote);

  @override
  Future<void> createBooking(BookingEntity booking) {
    final model = BookingModel.fromEntity(booking);
    return remote.createBooking(model);
  }

  @override
  Future<List<BookingEntity>> getUserBookings(String userId) async {
    final result = await remote.getUserBookings(userId);
    return result;
  }
}