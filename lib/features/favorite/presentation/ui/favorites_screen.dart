import 'package:flutter/material.dart';
import 'package:salon_app/core/constant_colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Favorites",style: TextStyle(color: AppColor.secondary),),centerTitle: true,backgroundColor: AppColor.primary,iconTheme: IconThemeData(color: AppColor.secondary)),
      body: Center(
        child: Text("Favorites screen"),
      ),
    );
  }
}