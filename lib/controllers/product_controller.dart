import 'dart:developer';
import 'dart:typed_data';

import 'package:e_commerce_admin_app/controllers/brand_controller.dart';
import 'package:e_commerce_admin_app/controllers/category_controller.dart';
import 'package:e_commerce_admin_app/models/category_model.dart';
import 'package:e_commerce_admin_app/models/product_model.dart';
import 'package:e_commerce_admin_app/services/product_api.dart';
import 'package:e_commerce_admin_app/views/product-views/main_product_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

import '../models/brand_model.dart' show BrandModel, BrandResponse;

class ProductController extends GetxController {
  //controller
  final brandController = Get.put(BrandResponse.empty());
  final categoryController = Get.find<CategoryController>();

  RxnString brandId = RxnString();
  RxnString categoryId = RxnString();
  final isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final productApi = ProductApi();

  Rx<ProductResponse> productRes = Rx(ProductResponse.empty());
  RxBool isSaved = false.obs;

  // ✅ Use Rx<Product?> for a single product update
  Rx<Product?> selectedProduct = Rx<Product?>(null);

  final RxList<Uint8List> filesByte = <Uint8List>[].obs;
  final RxList<String> imageUrls = <String>[].obs;

  final Rx<BrandModel?> getBrand = Rx<BrandModel?>(null);

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

  /// ✅ On Edit Product Tap
  void onEditProductTap(String id) {
    final product = productRes.value.data?.products.firstWhere(
      (e) => e.id == id,
      orElse: () => Product.empty(),
    );

    if (product != null && product.id != null) {
      selectedProduct.value = product;
      brandId.value = product.brand?.id;
      categoryId.value = product.categoryId?.id;

      // ✅ Set image URLs for display
      imageUrls.value = product.images.map((img) => img.url ?? '').toList();

      if (product.brand != null) {
        Get.find<BrandController>().toggleBrand(product.brand!);
      }
      if (product.categoryId != null) {
        Get.find<CategoryController>().toggleCategory(product.categoryId!);
      }

      Get.find<MainProductController>().toggleSwitch(2);
    }
  }
}
