import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:salon_app/core/custom_navigationbar.dart';
import 'package:salon_app/features/bookings/domain/entity/booking_entity.dart';
import 'package:salon_app/features/bookings/presentation/bloc/booking_bloc.dart';
import 'package:salon_app/features/bookings/presentation/ui/bookings_screen.dart';
import 'package:uuid/uuid.dart';


class BookingConfirmScreen extends StatefulWidget {
  final dynamic service;
  final dynamic staff;

  const BookingConfirmScreen({
    super.key,
    required this.service,
    required this.staff,
  });

  @override
  State<BookingConfirmScreen> createState() =>
      _BookingConfirmScreenState();
}

class _BookingConfirmScreenState extends State<BookingConfirmScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handleError);
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_7JLPi5q56mAlpG',
      'amount': (widget.service.price * 100).toInt(),
      'name': widget.service.name,
    };
 try {
    _razorpay.open(options);
  } catch (e) {
    print("Error: $e");
  }
    _razorpay.open(options);
  }

  void _handleSuccess(PaymentSuccessResponse response) async{
    final user = FirebaseAuth.instance.currentUser;

if (user == null) {
  print("User not logged in");
  return;
}
    final token = await FirebaseMessaging.instance.getToken();
    
  final booking = BookingEntity(
    id: Uuid().v4(),
    serviceId: widget.service.id,
    serviceName: widget.service.name,
    staffId: widget.staff.id,
    staffName: widget.staff.name,
    userId: user.uid,
    amount: widget.service.price,
    date: "2026-07-24",
    time: "10:30 AM",
    status: "confirmed",
    fcmToken: token??""
  );

  context.read<BookingBloc>().add(CreateBookingEvent(booking));
  context.read<BookingBloc>().add(
    GetUserBookingsEvent(user.uid),
  );
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => CustomNavigationbar(tabindex: 1,)),
  );
}

  void _handleError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Payment Failed")));
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(title: Text("Confirm Booking")),
  //     body: Center(
  //       child: Card(
  //         margin: EdgeInsets.all(20),
  //         child: Padding(
  //           padding: EdgeInsets.all(16),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Text(widget.service.name),
  //               Text("₹${widget.service.price}"),
  //               Text("Staff: ${widget.staff.name}"),
  //               SizedBox(height: 20),

  //               ElevatedButton(
  //                 onPressed: openCheckout,
  //                 child: Text("Proceed to Pay"),
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[100],

    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: const Text(
        "Confirm Booking",
        style: TextStyle(color: Colors.black),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
    ),

    body: Column(
      children: [

        /// 🔥 CONTENT
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// 🔥 SERVICE CARD
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      /// ICON
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.content_cut,
                            color: Colors.blue),
                      ),

                      const SizedBox(width: 12),

                      /// DETAILS
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.service.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "₹${widget.service.price}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// 🔥 STAFF SECTION
                const Text(
                  "Selected Staff",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundImage:
                            NetworkImage(widget.staff.image),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        widget.staff.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// 🔥 BOOKING INFO
                const Text(
                  "Booking Details",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      _rowItem("Date", "24 July 2026"),
                      _rowItem("Time", "10:30 AM"),
                      const Divider(),
                      _rowItem("Service Price",
                          "₹${widget.service.price}"),
                      _rowItem("Tax", "₹0"),
                      const Divider(),
                      _rowItem(
                        "Total",
                        "₹${widget.service.price}",
                        isBold: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        /// 🔥 BOTTOM PAYMENT BAR
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -2),
              )
            ],
          ),
          child: Row(
            children: [
              /// PRICE
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "₹${widget.service.price}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 20),

              /// PAY BUTTON
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: openCheckout,
                    child: const Text(
                      "Pay Now",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

/// 🔥 REUSABLE ROW
Widget _rowItem(String title, String value,
    {bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(
          value,
          style: TextStyle(
            fontWeight:
                isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}
}