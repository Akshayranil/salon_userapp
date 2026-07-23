import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:salon_app/features/bookings/domain/entity/booking_entity.dart';
import 'package:salon_app/features/bookings/presentation/bloc/booking_bloc.dart';
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

  void _handleSuccess(PaymentSuccessResponse response) {
    final booking = BookingEntity(
      id: Uuid().v4(),
      serviceId: widget.service.id,
      staffId: widget.staff.id,
      amount: widget.service.price,
      status: "success",
    );

    context.read<BookingBloc>().add(CreateBookingEvent(booking));

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Payment Success")));
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Confirm Booking")),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.service.name),
                Text("₹${widget.service.price}"),
                Text("Staff: ${widget.staff.name}"),
                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: openCheckout,
                  child: Text("Proceed to Pay"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}