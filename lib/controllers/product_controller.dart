import 'dart:developer';
import 'dart:typed_data';

import 'package:e_commerce_admin_app/controllers/category_controller.dart';
import 'package:e_commerce_admin_app/models/brand_model.dart';
import 'package:e_commerce_admin_app/models/product_model.dart';
import 'package:e_commerce_admin_app/services/product_api.dart';
import 'package:e_commerce_admin_app/views/product-views/main_product_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class ProductController extends GetxController {
  final isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final productApi = ProductApi();
  final brandController = Get.put(BrandResponse.empty());
  final categoryController = Get.find<CategoryController>();

  Rx<ProductResponse> productRes = Rx(ProductResponse.empty());
  RxBool isSaved = false.obs;

  // ✅ Use Rx<Product?> for a single product update
  Rx<Product?> selectedProduct = Rx<Product?>(null);
  final RxList<Uint8List> filesByte = <Uint8List>[].obs;

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  /// ✅ Fetch all products
  Future<void> getProducts() async {
    isLoading(true);
    final res = await productApi.fetchAllProducts();
    productRes.value = res;
    isLoading(false);
  }

  /// ✅ Image picker logic
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
          print("Image added: ${file.name}");
        }
      }
    } else {
      print('No file selected.');
    }
  }

  void removeImage(int index) {
    filesByte.removeAt(index);
  }

  /// ✅ Save product
  Future<void> saveProduct({
    required String brandId,
    required String categoryId,
    required String productName,
    required String description,
    required String price,
    required String stock,
  }) async {
    try {
      isSaved(true);
      await productApi.saveProduct(
        brandId: brandId,
        categoryId: categoryId,
        productName: productName,
        description: description,
        price: price,
        stock: stock,
        images: filesByte,
      );
      Get.snackbar('Success', 'Product saved successfully');
      getProducts(); // Refresh after saving
    } catch (e) {
      Get.snackbar('Save Failed', 'Product save failed');
    } finally {
      isSaved(false);
    }
  }

  /// ✅ Remove product by ID
  Future<void> removeProduct(String id) async {
    try {
      isLoading(true);
      await productApi.deleteProduct(id);
      final products = productRes.value.data?.products;
      products?.removeWhere((p) => p.id == id);
      productRes.refresh();
      Get.snackbar('Success', 'Product deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete product');
      log('Error while deleting product: $e');
    } finally {
      isLoading(false);
    }
  }

  /// ✅ When user taps to edit a product
  Future<void> onEditProductTap(String id) async {
    final products = productRes.value.data?.products;

    if (products == null || products.isEmpty) {
      Get.snackbar('Error', 'No products available');
      return;
    }

    final product = products.firstWhere((p) => p.id == id);

    selectedProduct.value = product;

    print("Editing product: ${product}");

    // Navigate to update form
    Get.find<MainProductController>().toggleSwitch(2);

  }
}
