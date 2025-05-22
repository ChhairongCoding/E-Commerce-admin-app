import 'dart:convert';
import 'package:e_commerce_admin_app/core/constand.dart';
import 'package:e_commerce_admin_app/services/local/token_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  final TokenService tokenService = TokenService();

  Future<void> login(String email, String password) async {
    Map<String, dynamic> body = {'email': email, 'password': password};

    try {
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false, 
      );

      var url = Uri.parse("$baseUrl/users/login");
      var res = await http.post(
        url,
        body: jsonEncode(body),
        headers: {
          'Content-Type': "application/json",
          "x-api-key": "my_super_secret_key",
        },
      );

      Get.back();

      if (res.statusCode == 201) {

        tokenService.setToken(jsonDecode(res.body)["token"]);
        Get.snackbar(
          "Sign In",
          "Sign in has been successfully!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color(0xff012B43),
          colorText: Colors.white,
          duration: Duration(seconds: 10),
        );
        Get.toNamed("/");
      } else {
        Get.snackbar(
          "Sign In",
          "Sign in error, please make sure your email and password are correct!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 10),
        );
      }
    } catch (e) {
      Get.back();
      print(e);
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
