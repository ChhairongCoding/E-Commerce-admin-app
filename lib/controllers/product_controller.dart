import 'dart:typed_data';

import 'package:e_commerce_admin_app/models/product_model.dart';
import 'package:e_commerce_admin_app/services/product_api.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class ProductController extends GetxController {
  final isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  ProductApi productApi = ProductApi();
  Rx<ProductResponse> productRes = Rx(ProductResponse.empty());
  RxBool isSaved = false.obs;

  final RxList<Uint8List> filesByte = <Uint8List>[].obs;
  // Controllers for form fields
  final productNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  Future<void> getProducts() async {
    isLoading(true);
    final res = await productApi.fetchAllProducts();
    productRes.value = res;
    isLoading(false);
  }

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
}
