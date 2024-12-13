import 'package:flutter/material.dart';

class ParameterTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;

  const ParameterTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[400]!,
          ),
          label: Text(
            label,
            style: TextStyle(
              color: Colors.grey[400]!,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[500]!,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[500]!,
            ),
          ),
          fillColor: Colors.grey[200]!,
        ),
        cursorColor: Colors.grey[600]!,
        enableSuggestions: false,
      ),
    );
  }
}
