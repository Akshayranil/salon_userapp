import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salon_app/features/bookings/data/model/booking_model.dart';

class BookingRemoteDataSource {
  final FirebaseFirestore firestore;

  BookingRemoteDataSource(this.firestore);

  Future<void> createBooking(BookingModel model) async {
    await firestore
        .collection("bookings")
        .doc(model.id)
        .set(model.toJson());
  }

  Future<List<BookingModel>> getUserBookings(String userId) async {
    final snapshot = await firestore
        .collection("bookings")
        .where("userId", isEqualTo: userId)
        .get();

    return snapshot.docs
        .map((doc) => BookingModel.fromJson(doc.data()))
        .toList();
  }
}