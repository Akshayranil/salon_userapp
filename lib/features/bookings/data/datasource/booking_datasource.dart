import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/booking_model.dart';

class BookingRemoteDataSource {
  final FirebaseFirestore firestore;

  BookingRemoteDataSource(this.firestore);

  Future<void> createBooking(BookingModel model) async {
    await firestore
        .collection("bookings")
        .doc(model.id)
        .set(model.toJson());
  }
}