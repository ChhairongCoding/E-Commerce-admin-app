import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateAddController extends GetxController{
  final Formkey = GlobalKey<FormState>();

  void validateForm ()async{
    if (Formkey.currentState!.validate()){
      Get.snackbar("Validate", "Test ");
    }
  }
}