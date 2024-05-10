import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;

  const CustomTextFormField({
    super.key,
    required this.hint,
    this.controller,
    this.onFieldSubmitted,
    this.onChanged,
    this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.blue, width: 2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.orange, width: 1)),
      ),
    );
  }
}
