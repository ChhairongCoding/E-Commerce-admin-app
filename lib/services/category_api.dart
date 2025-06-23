import 'dart:convert';
import 'dart:developer' as developer;
import 'package:e_commerce_admin_app/core/constand.dart';
import 'package:e_commerce_admin_app/models/category_model.dart';
import 'package:e_commerce_admin_app/services/local/token_service.dart';
import 'package:e_commerce_admin_app/views/category-views/main_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CategoryApi {

  final TokenService tokenService = TokenService();
  Future<CategoryResponse> getCategories() async {
  TokenService tokenService = TokenService();

    try {
      final token = tokenService.getToken();
      var url = Uri.parse("$baseUrl/categories");
      var res = await http.get(url, headers: headers(token));
      if (res.statusCode == 200) {
        return CategoryResponse.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>,
        );
      } else {
        developer.log("Failed to load categories. Status: ${res.statusCode}");
        return CategoryResponse.empty();
      }
    } catch (e) {
      developer.log(
        "Error getCategory: $e",
        name: "CategoryService.getCategories",
      );
      return CategoryResponse.empty();
    }
  }
  
  Future<void> saveCategory({
    required String name,
    required String description,
    required String parentCategory,
    required bool isActive
    // required List<Uint8List> images,
  }) async {
    final token = tokenService.getToken();

    final url = Uri.parse('$baseUrl/products');
    final res = await http.post(url, headers: headers(token));
    
    try {
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        developer.log('✅ Product created');
        Get.snackbar('Add product', "Add Product is successfully!");
         Get.find<MainCategoryController>().toggleSwitch(0);
      } else {
        developer.log('❌ Failed: ${res.body}');
      }
    } catch (e) {
      developer.log('❌ Error uploading product: $e');
    }
  }
}
