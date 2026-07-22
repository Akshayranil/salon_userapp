import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:salon_app/core/custom_navigationbar.dart';
import 'package:salon_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sign_in_button/sign_in_button.dart';

class GoogleAuthentication extends StatelessWidget {
  const GoogleAuthentication({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      // ignore: sized_box_for_whitespace
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.width * 0.14,
        child: SignInButton(
          Buttons.google,
          onPressed: () async {
            context.read<AuthBloc>().add(GoogleLogin());
          },
        ),
      ),
    );
  }
}
