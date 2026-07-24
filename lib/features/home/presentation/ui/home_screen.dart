import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_app/core/constant_colors.dart';
import 'package:salon_app/features/home/presentation/bloc/service_user_bloc.dart';
import 'package:salon_app/features/home/presentation/ui/service_detailscreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ServiceUserBloc>().add(LoadServicesEvent());
    return Scaffold(
      appBar: AppBar(title: Text("Services",style: TextStyle(color: AppColor.secondary),),centerTitle: true,backgroundColor: AppColor.primary,iconTheme: IconThemeData(color: AppColor.secondary)),

      body: BlocBuilder<ServiceUserBloc, ServiceUserState>(
        builder: (context, state) {
          if (state is ServiceLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ServiceError) {
            return Center(child: Text(state.message));
          }
          if (state is ServicesLoaded) {
            return GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75
              ),
              itemCount: state.services.length,
              itemBuilder: (context, index) {
  final service = state.services[index];

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ServiceDetailScreen(service: service),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Image Section
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: SizedBox(
              height: 120,
              width: double.infinity,
              child:   Container(
                      color: Colors.grey[300],
                      child: Icon(Icons.image, size: 40),
                    ),
            ),
          ),

          // 🔹 Text Section
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),

                // If you have price
               
                  Text(
                    "₹${service.price}",
                    style: TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}
