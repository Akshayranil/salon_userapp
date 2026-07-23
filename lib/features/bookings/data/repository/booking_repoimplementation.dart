import 'package:salon_app/features/bookings/data/datasource/booking_datasource.dart';

import '../../domain/entity/booking_entity.dart';
import '../../domain/repository/booking_repository.dart';
import '../model/booking_model.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remote;

  BookingRepositoryImpl(this.remote);

  @override
  Future<void> createBooking(BookingEntity booking) {
    final model = BookingModel.fromEntity(booking);
    return remote.createBooking(model);
  }
}