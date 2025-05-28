import 'package:flutter/material.dart';

class CustomTextfieldWidget extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? label;
  const CustomTextfieldWidget({super.key, this.hintText, this.controller,this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
       crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label"),
        TextFormField(
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
          validator: (value) {
            if(value == null || value.isEmpty){
              return "Please Enter some text";
            }return null;
          },
        ),
      ],
    );
  }
}
