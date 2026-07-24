
import 'package:flutter/material.dart';
import 'package:salon_app/core/constant_colors.dart';
import 'package:salon_app/features/bookings/presentation/ui/bookings_screen.dart';
import 'package:salon_app/features/favorite/presentation/ui/favorites_screen.dart';
import 'package:salon_app/features/home/presentation/ui/home_screen.dart';
import 'package:salon_app/features/profile/presentation/ui/profile_screen.dart';
import 'package:salon_app/features/profile/presentation/ui/profile_view.dart';

class CustomNavigationbar extends StatelessWidget {
  final int? tabindex;
  const CustomNavigationbar({super.key,this.tabindex});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: tabindex??0,
      length: 4,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: AppColor.primary,
          height: 70,
          child: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Home"),
              Tab(icon: Icon(Icons.bookmark_added_sharp), text: "Booked"),
              Tab(icon: Icon(Icons.favorite), text: "Saved"),
              Tab(icon: Icon(Icons.person), text: "Profile"),
            ],
            indicatorColor: Colors.transparent,
            labelColor: AppColor.secondary,
            unselectedLabelColor: Colors.white70,
          ),
        ),
        body: TabBarView(
          children: [
            HomeScreen(),
            BookingScreen(),
            FavoritesScreen(),
            ProfileView()
          ],
        ),
      ),
    );
  }
}
