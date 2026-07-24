import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_app/features/home/domain/entity/service_entity.dart';
import 'package:salon_app/features/home/presentation/bloc/service_user_bloc.dart';
import 'package:salon_app/features/home/presentation/ui/booking_confirmationscreen.dart';

class ServiceDetailScreen extends StatefulWidget {
  final ServiceEntity service;

  const ServiceDetailScreen({super.key, required this.service});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  int? selectedIndex;

  @override
  void initState() {
    super.initState();

    /// 🔥 LOAD STAFF
    context.read<ServiceUserBloc>().add(
          LoadStaffByServiceEvent(widget.service.id),
        );
  }

  @override
 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[100],

    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text(
        widget.service.name,
        style: const TextStyle(color: Colors.black),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
    ),

    body: Column(
      children: [
        const SizedBox(height: 10),

        /// 🔥 SERVICE CARD
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.service.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "₹${widget.service.price}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        /// 🔥 TITLE
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Select Staff",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        /// 🔥 STAFF LIST
        Expanded(
          child: BlocBuilder<ServiceUserBloc, ServiceUserState>(
            builder: (context, state) {
              if (state is ServiceLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is StaffLoaded) {
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: state.staff.length,
                  itemBuilder: (context, index) {
                    final staff = state.staff[index];
                    final isSelected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blue.shade50
                              : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? Colors.blue
                                : Colors.grey.shade200,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            /// 🔥 STAFF IMAGE
                            CircleAvatar(
                              radius: 28,
                              backgroundImage:
                                  NetworkImage(staff.image),
                            ),

                            const SizedBox(width: 12),

                            /// 🔥 NAME
                            Expanded(
                              child: Text(
                                staff.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            /// 🔥 SELECT ICON
                            AnimatedContainer(
                              duration:
                                  const Duration(milliseconds: 300),
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? Colors.blue
                                    : Colors.grey.shade300,
                              ),
                              child: Icon(
                                Icons.check,
                                size: 18,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ),

        /// 🔥 BOTTOM BUTTON
        BlocBuilder<ServiceUserBloc, ServiceUserState>(
          builder: (context, state) {
            if (state is! StaffLoaded) return const SizedBox();

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  )
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: selectedIndex == null
                      ? null
                      : () {
                          final staff = state.staff[selectedIndex!];

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BookingConfirmScreen(
                                service: widget.service,
                                staff: staff,
                              ),
                            ),
                          );
                        },
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}
}