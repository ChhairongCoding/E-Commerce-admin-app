import 'dart:typed_data';

import 'package:e_commerce_admin_app/controllers/product_controller.dart';
import 'package:e_commerce_admin_app/models/brand_model.dart';
import 'package:e_commerce_admin_app/services/brand_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  final ProductController productController = Get.find<ProductController>();
  final isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  Rx<BrandResponse> brandRes = BrandResponse.empty().obs;
  final BrandService _brandService = BrandService();
  var imageBytes = <Uint8List>[].obs;
  final RxList<Uint8List> filesByte = <Uint8List>[].obs;

  Rx<BrandModel> selectedBrand = BrandModel().obs;
  @override
  void onInit() {
    super.onInit();
    getBrands();
  }

  List<String> headerTable = ['ID', 'Brandd Name', 'Brand Count', 'Action'];

  Future<void> pickerImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true,
      type: FileType.image,
    );

    if (result != null) {
      for (var file in result.files) {
        if (file.bytes != null) {
          filesByte.add(file.bytes!);
        }
      }
    }
  }

  Future<void> refreshBrands() async {
    // Add your logic to refresh/reload the brands here.
    // For example, you might call a service to fetch brands and update state.
    await getBrands(); // Replace with your actual method to fetch brands.
    update(); // Notify listeners if using GetX state management.
  }

  Future<void> getBrands() async {
    isLoading(true);
    final data = await _brandService.getBrands();
    brandRes.value = data;
    isLoading(false);
  }

  void toggleBrand(BrandModel brand) {
    selectedBrand.value = brand;
  }

  void addBrand(String name, String description, Uint8List image) async {
    isLoading(true);
    await BrandService().addProduct(name, description, image);
    getBrands();
  }
}
