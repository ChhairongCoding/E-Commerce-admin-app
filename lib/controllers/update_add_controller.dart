import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateAddController extends GetxController{
  final formkey = GlobalKey<FormState>();

  void validateForm ()async{
    if (formkey.currentState!.validate()){
      Get.snackbar("Validate", "Test ");
    }
  }
}