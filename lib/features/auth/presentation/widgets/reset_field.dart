
// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/core/constant_colors.dart';

class ResetPasswordField extends StatelessWidget {
  const ResetPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            final TextEditingController emailcontroller =
                TextEditingController();
            return AlertDialog(
              title: Text(
                'Reset Password',
                style: TextStyle(
                  color: AppColor.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    resetPassword(context, emailcontroller.text.trim());
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                  ),
                  child: Text(
                    'Sent',
                    style: TextStyle(color: AppColor.secondary),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Text('Forgot Password?'),
    );
  }
}

Future<void> resetPassword(BuildContext context, String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password reset link sent to $email')),
    );
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error : ${e.toString()}')));
  }
}
