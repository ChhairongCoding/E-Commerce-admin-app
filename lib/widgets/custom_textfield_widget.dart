import 'package:flutter/material.dart';

class CustomTextfieldWidget extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  const CustomTextfieldWidget({super.key, this.hintText, this.controller});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Color.fromARGB(255, 228, 228, 228),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
