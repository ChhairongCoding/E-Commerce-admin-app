import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:typed_data';
import 'package:e_commerce_admin_app/controllers/brand_controller.dart';
import 'package:e_commerce_admin_app/core/constand.dart';
import 'package:e_commerce_admin_app/models/brand_model.dart';
import 'package:e_commerce_admin_app/services/local/token_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BrandService {
  Future<BrandResponse> getBrands() async {
    try {
      final token = TokenService().getToken();
      final url = Uri.parse("$baseUrl/brands");
      final res = await http.get(url, headers: headers(token));
      // developer.log("BrandRes: ${res.body}");
      if (res.statusCode == 200) {
        return BrandResponse.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>,
        );
      } else {
        return BrandResponse.empty();
      }
    } catch (e) {
      developer.log("Error getbrand: $e", name: "BrandService.getBrands");
      return BrandResponse.empty();
    }
  }

  Future<void> addProduct(
    String brandName,
    String description,
    Uint8List image,
  ) async {
    try {
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      final token = TokenService().getToken();
      final url = Uri.parse("$baseUrl/brands");
      final request = http.MultipartRequest('POST', url);

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      request.fields['name'] = brandName;
      request.fields['description'] = description;

      if (image.isNotEmpty) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'image',
            image,
            filename: 'image_.jpg',
          ),
        );
      }

      final response = await request.send();
      final res = await http.Response.fromStream(response);

      if (res.statusCode == 200 || res.statusCode == 201) {
        Get.back(); // Close the dialog
        Get.snackbar('Add Brand', "Add Brand is successfully!");
        // Refresh brands in BrandController
        if (Get.isRegistered<BrandController>()) {
          await Get.find<BrandController>().refreshBrands();
        }
      } else {
        developer.log('❌ Failed: ${res.body}');
      }
    } catch (e) {
      developer.log('❌ Error uploading product: $e');
    }
  }
}
