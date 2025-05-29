import 'dart:developer';

import 'package:e_commerce_admin_app/models/category_model.dart';
import 'package:e_commerce_admin_app/services/category_api.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  RxList<Category> categories = <Category>[].obs;
  final CategoryApi categoryApi = CategoryApi();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await categoryApi.getCategory();
      categories.addAll(response.cast<Category>());
      log('Fetched ${categories.length} categories.');
    } catch (e) {
      log('Failed to fetch categories: $e');
    }
  }
}
