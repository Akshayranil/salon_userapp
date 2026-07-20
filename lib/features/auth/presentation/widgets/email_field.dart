// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:salon_app/core/constant_colors.dart';

class EmailLoginField extends StatelessWidget {
  TextEditingController emailcontroller;
   EmailLoginField({super.key,required this.emailcontroller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 55),
      child: TextField(
        controller: emailcontroller,
        decoration: InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColor.primary, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
