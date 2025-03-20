import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscureText;
  final TextInputType textInputType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isObscureText,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        keyboardType: textInputType,
        controller: controller,
        style: TextStyle(color: Colors.grey[200]),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[200]!,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[200]!,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[200]!,
            ),
          ),
          fillColor: Colors.grey[200]!,
        ),
        cursorColor: Colors.grey[200]!,
        enableSuggestions: false,
        obscureText: isObscureText,
      ),
    );
  }
}
