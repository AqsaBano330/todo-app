
import 'package:flutter/material.dart';
import 'package:todoapp/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.obscuretext,
    required this.label, required this.hinttext,
  });

  final TextEditingController controller;
  final bool obscuretext;
  final String label;
  final String hinttext;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 320,
      child: TextField(
        cursorHeight: 20,
        obscureText: obscuretext,
        controller: controller,
        cursorColor: AppColors.themecolor,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
          label: Text(label),
          hintText: hinttext,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: AppColors.themecolor, // Your themed color
              width: 1.0, // Border width
            ),
          ),
        ),
      ),
    );
  }
}
