import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_admin_app/core/constand.dart';
import 'package:e_commerce_admin_app/models/product_model.dart';
import 'package:e_commerce_admin_app/services/local/token_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  TokenService tokenService = TokenService();

  Future<List<Product>> fetchAllProducts() async {
    try {
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      final token = tokenService.getToken();
      var url = Uri.parse("$baseUrl/products");
      var res = await http.get(
        url,
        headers: {
          "x-api-key": "my_super_secret_key",
          "Authorization": "Bearer $token",
        },
      );
      if (res.statusCode == 200) {
        final List<dynamic> data = jsonDecode(res.body);
        
        return data.map<Product>((item) => Product.fromJson(item)).toList();
      } else {
        throw "Fetching Products error: ${res.statusCode}";
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
