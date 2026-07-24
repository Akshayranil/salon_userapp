import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_app/core/constant_colors.dart';
import 'package:salon_app/features/bookings/presentation/bloc/booking_bloc.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    context.read<BookingBloc>().add(GetUserBookingsEvent(userId));

    return Scaffold(
      appBar: AppBar(title: Text("My bookings",style: TextStyle(color: AppColor.secondary),),centerTitle: true,backgroundColor: AppColor.primary,iconTheme: IconThemeData(color: AppColor.secondary)),
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          if (state is BookingLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is BookingLoaded) {
            return ListView.builder(
              itemCount: state.bookings.length,
              itemBuilder: (context, index) {
                final b = state.bookings[index];

                return Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.deepPurple],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        b.serviceName,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text("Staff: ${b.staffName}",
                          style: TextStyle(color: Colors.white)),
                      Text("Date: ${b.date}",
                          style: TextStyle(color: Colors.white)),
                      Text("Time: ${b.time}",
                          style: TextStyle(color: Colors.white)),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("₹${b.amount}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(b.status,
                                style: TextStyle(color: Colors.white)),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }

          return Center(child: Text("No bookings"));
        },
      ),
    );
  }
}