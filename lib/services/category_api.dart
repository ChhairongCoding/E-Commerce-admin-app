import 'dart:convert';
import 'dart:developer' as developer;
import 'package:e_commerce_admin_app/core/constand.dart';
import 'package:e_commerce_admin_app/models/category_model.dart';
import 'package:e_commerce_admin_app/services/local/token_service.dart';
import 'package:e_commerce_admin_app/views/category-views/category_screen.dart';
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
    // String parentCategory,
    required bool isActive,
  }) async {
    // Map<String, dynamic> body = {
    //   'name': name,
    //   'description': description,
    //   'parentCategory': parentCategory,
    //   'isActive': isActive,
    // };
    try {
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      final token = tokenService.getToken();
      final url = Uri.parse('$baseUrl/categories');
      final res = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': name,
          'description': description,
          // if (parentCategory.isNotEmpty) 'parentCategory': parentCategory,
          'isActive': isActive,
        }),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        developer.log('✅ Category created');
        Get.snackbar('Add Category', "Add Category is successfully!");
        Get.find<MainCategoryController>().toggleSwitch(0);
        print(res.body);
      } else {
        Get.snackbar('Add Category', "Add Category is Error!");

        developer.log('❌ Failed: ${res.body}');
      }
    } catch (e) {
      developer.log('❌ Error uploading Category: $e');
    }
  }

  Future<void> removeCategory(String id) async {
    try {
      final token = TokenService().getToken();
      final url = Uri.parse("$baseUrl/categories/$id");
      final res = await http.delete(url, headers: headers(token));

      if (res.statusCode == 200) {
        Get.snackbar("Success", jsonDecode(res.body)["message"]);
      } else {
        developer.log("Remove error: ${res.body}");
      }
    } catch (e) {
      developer.log("$e");
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      final token = tokenService.getToken();
      var url = Uri.parse("$baseUrl/products/$id");
      final res = await http.delete(
        url,
        headers: {
          "x-api-key": "my_super_secret_key",
          "Authorization": "Bearer $token",
        },
      );
      Get.back();

      if (res.statusCode == 201) {
        developer.log("Product delete successfully!");
        Get.snackbar(
          "Success!",
          "Update product successfully!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color(0xff012B43),
          colorText: Colors.white,
          duration: Duration(seconds: 10),
        );
        Get.to(CategoryScreen());
      } else {
        developer.log("Product delete error: ${res.statusCode}");
      }
    } catch (e) {
      developer.log("error product deleted : $e");
    }
  }

  Future<void> updateProduct({
    required String productId,
    String? brandId,
    String? categoryId,
    String? productName,
    String? description,
    String? price,
    String? stock,
  }) async {
    final url = Uri.parse('$baseUrl/products/$productId');
    final token = tokenService.getToken();

    final Map<String, dynamic> updateData = {};
    if (brandId != null) updateData['brand'] = brandId;
    if (categoryId != null) updateData['categoryId'] = categoryId;
    if (productName != null) updateData['name'] = productName;
    if (description != null) updateData['description'] = description;
    if (price != null) updateData['price'] = int.tryParse(price);
    if (stock != null) updateData['stock'] = int.tryParse(stock);

    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(updateData),
      );

      Get.back(); // Close dialog

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success!",
          "Product updated successfully!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xff012B43),
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );

        /// ⬇️ Go back to main product list view
        Get.find<MainCategoryController>().toggleSwitch(0);
      } else {
        print('Failed to add category: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updateCategory(
    String id,
    String name,
    String description,
    bool isActive,
  ) async {
    Map<String, dynamic> body = {
      "name": name,
      "description": description,
      "isActive": isActive,
    };

    try {
      final token = TokenService().getToken();
      final url = Uri.parse("$baseUrl/categories/$id");
      final res = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      if (res.statusCode == 200) {
        Get.snackbar(
          "Success!",
          "Category updated successfully!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xff012B43),
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );

        /// ⬇️ Go back to main product list view
        Get.find<MainCategoryController>().toggleSwitch(0);
      } else {
        print('Failed to update category : ${res.statusCode}');
        print('Response body: ${res.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
