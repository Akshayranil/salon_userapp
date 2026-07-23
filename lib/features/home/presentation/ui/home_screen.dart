import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_app/features/home/presentation/bloc/service_user_bloc.dart';
import 'package:salon_app/features/home/presentation/ui/service_detailscreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(title: Text("Services")),

      body: BlocBuilder<ServiceUserBloc, ServiceUserState>(
        builder: (context, state) {
          if (state is ServiceLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is ServicesLoaded) {
            return GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
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
                  child: Card(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(service.image, fit: BoxFit.cover),
                        ),
                        Text(service.name),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}