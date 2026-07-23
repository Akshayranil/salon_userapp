import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_app/features/home/domain/entity/service_entity.dart';
import 'package:salon_app/features/home/presentation/bloc/service_user_bloc.dart';

class ServiceDetailScreen extends StatelessWidget {
  final ServiceEntity service;

  const ServiceDetailScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    context.read<ServiceUserBloc>().add(
          LoadStaffByServiceEvent(service.id),
        );

    return Scaffold(
      appBar: AppBar(title: Text(service.name)),

      body: Column(
        children: [
          SizedBox(height: 20),

          /// 🔥 SERVICE PRICE
          Text(
            "₹${service.price}",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 20),

          /// 🔥 STAFF LIST
          Expanded(
            child: BlocBuilder<ServiceUserBloc, ServiceUserState>(
              builder: (context, state) {
                if (state is ServiceLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is StaffLoaded) {
                  return ListView.builder(
                    itemCount: state.staff.length,
                    itemBuilder: (context, index) {
                      final staff = state.staff[index];

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(staff.image),
                        ),
                        title: Text(staff.name),

                        /// 🔥 SELECT STAFF
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${staff.name} selected"),
                            ),
                          );
                        },
                      );
                    },
                  );
                }

                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}