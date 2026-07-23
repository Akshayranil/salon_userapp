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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.service.name)),

      body: Column(
        children: [
          const SizedBox(height: 20),

          /// 🔥 SERVICE PRICE
          Text(
            "₹${widget.service.price}",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          /// 🔥 STAFF LIST
          Expanded(
            child: BlocBuilder<ServiceUserBloc, ServiceUserState>(
              builder: (context, state) {
                if (state is ServiceLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is StaffLoaded) {
                  return ListView.builder(
                    itemCount: state.staff.length,
                    itemBuilder: (context, index) {
                      final staff = state.staff[index];
                      final isSelected = selectedIndex == index;

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(staff.image),
                        ),
                        title: Text(staff.name),

                        /// ✅ HIGHLIGHT SELECTED
                        tileColor:
                            isSelected ? Colors.blue.shade100 : null,

                        /// 🔥 SELECT STAFF
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
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

              return Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectedIndex == null
                        ? null
                        : () {
                            final staff =
                                state.staff[selectedIndex!];

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
                    child: const Text("Proceed"),
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