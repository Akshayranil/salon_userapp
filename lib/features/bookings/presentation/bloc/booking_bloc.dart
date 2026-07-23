import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salon_app/features/bookings/domain/entity/booking_entity.dart';
import 'package:salon_app/features/bookings/domain/usecase/booking_usecase.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final CreateBooking createBooking;

  BookingBloc(this.createBooking) : super(BookingInitial()) {
    on<CreateBookingEvent>((event, emit) async {
      emit(BookingLoading());

      try {
        await createBooking(event.booking);
        emit(BookingSuccess());
      } catch (e) {
        emit(BookingFailure(e.toString()));
      }
    });
  }
}
