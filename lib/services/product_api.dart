import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:e_commerce_admin_app/core/constand.dart';
import 'package:e_commerce_admin_app/models/product_model.dart';
import 'package:e_commerce_admin_app/services/local/token_service.dart';
import 'package:e_commerce_admin_app/views/product-views/main_product_controller.dart';
import 'package:e_commerce_admin_app/views/product-views/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class ProductApi {
  TokenService tokenService = TokenService();

  Future<ProductResponse> fetchAllProducts() async {
    try {
      final token = tokenService.getToken();

      var url = Uri.parse("$baseUrl/products/my-products");
      var res = await http.get(
        url,
        headers: {
          "x-api-key": "my_super_secret_key",
          "Authorization": "Bearer $token",
        },
      );

      if (res.statusCode == 200) {
        return ProductResponse.fromJson(jsonDecode(res.body));
      } else {
        throw "Fetching Products error: ${res.body}";
      }
    } catch (e) {
      log("Error: $e");
      return ProductResponse.empty();
    }
  }

  Future<void> saveProduct({
    required String brandId,
    required String categoryId,
    required String productName,
    required String description,
    required String price,
    required String stock,
    required List<Uint8List> images,
  }) async {

    Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
    final url = Uri.parse('$baseUrl/products');
    final request = http.MultipartRequest('POST', url);
    final token = tokenService.getToken();

    request.headers['Authorization'] = 'Bearer $token';
    request.headers['Accept'] = 'application/json';

    request.fields['brand'] = brandId;
    request.fields['categoryId'] = categoryId;
    request.fields['name'] = productName;
    request.fields['description'] = description;
    request.fields['price'] = price;
    request.fields['stock'] = stock;

    for (int i = 0; i < images.length; i++) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'images',
          images[i],
          filename: 'image_$i.jpg',
          // contentType: MediaType('image', 'jpeg'),
        ),
      );
    }
    try {
      
      final response = await request.send();
      final res = await http.Response.fromStream(response);
      if (res.statusCode == 200 || res.statusCode == 201) {
        developer.log('✅ Product created');
        Get.snackbar('Add product', "Add Product is successfully!");
         Get.find<MainProductController>().toggleSwitch(0);
      } else {
        developer.log('❌ Failed: ${res.body}');
      }
    } catch (e) {
      developer.log('❌ Error uploading product: $e');
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
        Get.to(ProductScreen());
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
          'x-api-key': 'my_super_secret_key',
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
        Get.find<MainProductController>().toggleSwitch(0);
      } else {
        log('Failed to update product: ${response.statusCode}');
        log('Response body: ${response.body}');
      }
    } catch (e) {
      log('Error: $e');
    }
  }
}
