import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_app/core/constant_colors.dart';
import 'package:salon_app/features/favorite/presentation/bloc/favorites_bloc.dart';
import 'package:salon_app/features/home/domain/entity/service_entity.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoritesBloc>().add(
        LoadFavoritesEvent(),
      );
    });

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Your Favorites ",
          style: TextStyle(fontWeight: FontWeight.bold,color: AppColor.secondary),
        ),
        centerTitle: true,
        backgroundColor: AppColor.primary,
      ),

      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {

          /// 🔄 LOADING
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          /// ❌ ERROR
          if (state is FavoritesError) {
            return Center(child: Text(state.message));
          }

          /// 📦 LOADED
          if (state is FavoritesLoaded) {

            /// 🪹 EMPTY STATE
            if (state.favorites.isEmpty) {
              return _buildEmptyState();
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final service = state.favorites[index];
                return _favoriteCard(context, service);
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  /// ❤️ FAVORITE CARD UI (UNCHANGED ✨)
  Widget _favoriteCard(BuildContext context, ServiceEntity service) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      height: 120,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
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

            /// 🌑 GRADIENT OVERLAY
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

            /// 🧾 CONTENT
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  /// TEXT
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "₹${service.price}",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  /// ❤️ REMOVE BUTTON
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        context.read<FavoritesBloc>().add(
                          ToggleFavoriteEvent(service),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🪹 EMPTY STATE UI (UNCHANGED)
  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: Colors.grey),
          SizedBox(height: 12),
          Text(
            "No Favorites Yet",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          Text(
            "Start adding services you love ❤️",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}