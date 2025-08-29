import 'package:flutter/material.dart';

class CustomTextfieldWidget extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? label;
  final String? Function(String?)? validator;
  final int? maxLines;
  final bool? isObsecureText;
  const CustomTextfieldWidget({
    super.key,
    this.hintText,
    this.controller,
    this.label,
    this.validator,
    this.maxLines,
    this.isObsecureText ,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(label!, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.transparent,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          obscureText: isObsecureText != true ? false : true,
          maxLines: maxLines,
          validator:
              validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter some text";
                }
                return null;
              },
        ),
      ],
    );
  }
}
