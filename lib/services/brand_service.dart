import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:typed_data';
import 'package:e_commerce_admin_app/controllers/brand_controller.dart';
import 'package:e_commerce_admin_app/core/constand.dart';
import 'package:e_commerce_admin_app/models/brand_model.dart';
import 'package:e_commerce_admin_app/services/local/token_service.dart';
import 'package:e_commerce_admin_app/views/brand-views/main_brand_controller.dart';
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
    bool isActive,
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
      request.fields['isActive'] = isActive.toString();

      if (image.isNotEmpty) {
        request.files.add(
          http.MultipartFile.fromBytes('image', image, filename: 'image_.jpg'),
        );
      }

      final response = await request.send();
      final res = await http.Response.fromStream(response);

      if (res.statusCode == 200 || res.statusCode == 201) {
        Get.back(); // Close the dialog
        Get.snackbar('Add Brand', "Add Brand is successfully!");
        Get.find<MainBrandController>().toggleSwitch(0);
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

  Future<void> removeBrand(String id) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final token =  TokenService().getToken();

      final url = Uri.parse('$baseUrl/brands/$id');
      final res = await http.delete(url, headers: headers(token));

      if (Get.isDialogOpen ?? false) {
        Get.back(); // Close the loading dialog
      }

      if (res.statusCode == 200 || res.statusCode == 201) {
        Get.snackbar('Remove Brand', 'Brand removed successfully!');

        Get.find<MainBrandController>().toggleSwitch(0);
        if (Get.isRegistered<BrandController>()) {
          await Get.find<BrandController>().refreshBrands();
        }
      } else {
        developer.log('❌ Failed: ${res.body}');
        Get.snackbar('Remove Failed', 'Server responded with error');
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      developer.log('❌ Exception: $e');
      Get.snackbar('Error', 'Something went wrong while removing brand.');
    }
  }

  Future<void> updateBrand(
    String id,
    String name,
    Uint8List image,
  ) async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final url = Uri.parse('$baseUrl/brands/$id');
      final token =  TokenService().getToken();

      // Create MultipartRequest for uploading image + text fields
      final request = http.MultipartRequest('PUT', url)
        ..headers.addAll({
          'x-api-key': 'my_super_secret_key',
          'Authorization': 'Bearer $token',
        })
        ..fields['name'] = name
        ..files.add(
          http.MultipartFile.fromBytes(
            'image', // 👈 your backend should expect this field name
            image,
            filename: 'brand_image.png',
          ),
        );

      final response = await http.Response.fromStream(await request.send());

      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success!",
          "Brand updated successfully!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xff012B43),
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );

        Get.find<MainBrandController>().toggleSwitch(0);
      } else {
        developer.log('Failed to update brand: ${response.statusCode}');
        developer.log('Response body: ${response.body}');
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      developer.log('❌ Exception: $e');
      Get.snackbar('Error', 'Something went wrong while updating brand.');
    }
  }
}
