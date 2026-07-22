import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salon_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:salon_app/features/profile/presentation/ui/profile_screen.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {

   WidgetsBinding.instance.addPostFrameCallback((_) {
  context.read<AuthBloc>().add(GetProfileEvent());
});

    return const ProfileScreen();
  }
}