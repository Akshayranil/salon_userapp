// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:salon_app/core/constant_colors.dart';
// import 'package:salon_app/features/home/presentation/bloc/service_user_bloc.dart';
// import 'package:salon_app/features/home/presentation/ui/service_detailscreen.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     context.read<ServiceUserBloc>().add(LoadServicesEvent());
//     return Scaffold(
//       appBar: AppBar(title: Text("Services",style: TextStyle(color: AppColor.secondary),),centerTitle: true,backgroundColor: AppColor.primary,iconTheme: IconThemeData(color: AppColor.secondary)),

//       body: BlocBuilder<ServiceUserBloc, ServiceUserState>(
//         builder: (context, state) {
//           if (state is ServiceLoading) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (state is ServiceError) {
//             return Center(child: Text(state.message));
//           }
//           if (state is ServicesLoaded) {
//             return GridView.builder(
//               padding: EdgeInsets.all(10),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 0.75
//               ),
//               itemCount: state.services.length,
//               itemBuilder: (context, index) {
//   final service = state.services[index];

//   return GestureDetector(
//     onTap: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => ServiceDetailScreen(service: service),
//         ),
//       );
//     },
//     child: Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.shade300,
//             blurRadius: 6,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // 🔹 Image Section
//           ClipRRect(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//             child: SizedBox(
//               height: 120,
//               width: double.infinity,
//               child:   Container(
//                       color: Colors.grey[300],
//                       child: Icon(Icons.image, size: 40),
//                     ),
//             ),
//           ),

//           // 🔹 Text Section
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   service.name,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 5),

//                 // If you have price
               
//                   Text(
//                     "₹${service.price}",
//                     style: TextStyle(
//                       color: AppColor.primary,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
//             );
//           }

//           return SizedBox();
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_app/core/constant_colors.dart';
import 'package:salon_app/features/favorite/presentation/bloc/favorites_bloc.dart';
import 'package:salon_app/features/home/domain/entity/service_entity.dart';
import 'package:salon_app/features/home/presentation/bloc/service_user_bloc.dart';
import 'package:salon_app/features/home/presentation/ui/service_detailscreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    /// ✅ FIX: avoid calling in build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceUserBloc>().add(LoadServicesEvent());
      context.read<FavoritesBloc>().add(LoadFavoritesEvent());
    });

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: Text(
          "Services",
          style: TextStyle(color: AppColor.secondary),
        ),
        centerTitle: true,
        backgroundColor: AppColor.primary,
        iconTheme: IconThemeData(color: AppColor.secondary),
      ),

      body: BlocBuilder<ServiceUserBloc, ServiceUserState>(
        builder: (context, state) {

          if (state is ServiceLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ServiceError) {
            return Center(child: Text(state.message));
          }

          if (state is ServicesLoaded) {

            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount: state.services.length,
              itemBuilder: (context, index) {

                final service = state.services[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ServiceDetailScreen(service: service),
                      ),
                    );
                  },
                  child: _serviceCard(context, service),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  /// 🌟 MODERN SERVICE CARD
  Widget _serviceCard(BuildContext context, ServiceEntity service) {

    final isFav = context
        .watch<FavoritesBloc>()
        .favorites
        .any((e) => e.id == service.id);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [

            /// 🖼 IMAGE
            Positioned.fill(
              child: Image.network(
                service.image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, size: 40),
                ),
              ),
            ),

            /// 🌑 GRADIENT
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            /// ❤️ FAVORITE BUTTON
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  context.read<FavoritesBloc>().add(
                        ToggleFavoriteEvent(service),
                      );
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isFav
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ),
            ),

            /// 🧾 TEXT INFO
            Positioned(
              left: 10,
              right: 10,
              bottom: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "₹${service.price}",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
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
}