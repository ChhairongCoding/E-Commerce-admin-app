import 'dart:typed_data';
import 'package:e_commerce_admin_app/controllers/product_controller.dart';
import 'package:e_commerce_admin_app/models/brand_model.dart';
import 'package:e_commerce_admin_app/services/brand_service.dart';
import 'package:e_commerce_admin_app/views/brand-views/main_brand_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BrandController extends GetxController {
  final ProductController productController = Get.find<ProductController>();
  final isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final RxBool isUpdate = false.obs;

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

  List<String> headerTable = ['ID', 'Brand Name', 'Brand Count', 'Action'];

  Future<void> pickerImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      withData: true,
      type: FileType.image,
    );

    if (result != null) {
      for (var file in result.files) {
        if (file.bytes != null) {
          filesByte.clear(); // Clear previous images
          filesByte.add(file.bytes!);
        }
      }
    }
  }

  void removeImage(int index) {
    filesByte.removeAt(index);
  }

  Future<void> refreshBrands() async {
    await getBrands();
    update();
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

  void addBrand(String name, bool isActive, Uint8List image) async {
    isLoading(true);
    await BrandService().addProduct(name, isActive ,image);
    getBrands();
    isLoading(false);
  }

  Future<void> removeBrand(String id) async {
    try {
      isLoading(true);
      await _brandService.removeBrand(id);
    } finally {
      isLoading(false);
    }
  }

  Future<void> onEditBrandTap(String id) async {
    isUpdate(true);
    final brand = brandRes.value.data.firstWhere(
      (e) => e.id == id,
      orElse: () => BrandModel(),
    );
    if (brand.id != null) {
      selectedBrand.value = brand;
      // Load existing image if available
      filesByte.clear();
      if (brand.image != null) {
        try {
          // Fetch the image from the URL
          final response = await http.get(Uri.parse(brand.image!));
          if (response.statusCode == 200) {
            filesByte.add(response.bodyBytes);
          }
        } catch (e) {
          Get.snackbar('Error', 'Failed to load brand image');
        }
      }
    }
    Get.find<MainBrandController>().toggleSwitch(1);
  }

  Future<void> updateBrand(String name, String description, Uint8List? image) async {
    isLoading(true);
    try {
      // Use existing image if no new image is provided
      Uint8List imageToSend = image ?? (filesByte.isNotEmpty ? filesByte.first : Uint8List(0));
      await BrandService().updateBrand(
        selectedBrand.value.id.toString(),
        name,
        imageToSend,
      );
      await getBrands(); // Refresh brands after update
      isUpdate(false);
      filesByte.clear();
      Get.find<MainBrandController>().toggleSwitch(0);
    } finally {
      isLoading(false);
    }
  }
}