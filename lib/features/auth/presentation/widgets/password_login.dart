import 'package:flutter/material.dart';
import 'package:salon_app/core/constant_colors.dart';

// ignore: must_be_immutable
class PasswordLoginField extends StatelessWidget {
  final TextEditingController passwordcontroller;
  bool obscureText = true;
  PasswordLoginField({super.key,required this.passwordcontroller});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return TextField(
          controller: passwordcontroller,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColor.primary, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
            ),
          ),
        );
      },
    );
  }
}
