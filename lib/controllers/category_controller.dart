import 'dart:developer';

import 'package:e_commerce_admin_app/models/category_model.dart';
import 'package:e_commerce_admin_app/services/category_api.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  Rx<CategoryResponse> CategoryRes = CategoryResponse.empty().obs;
  final isLoading = false.obs;
  final CategoryApi _categoryApi = CategoryApi();
  Rx<Category> selectedCategory = Category.empty().obs;

  List<String> headerTable = [
    'ID',
    'Category Name',
    'Product Count',
    'Status',
    'Action',
  ];

  List<List<dynamic>> rowsTable = [
    ['1', 'Nike', '100', 'Active', 'Action'],
    ['1', 'Nike', '100', 'Active', 'Action'],
  ];

  @override
  void onInit() {
    super.onInit();
    getCategory();
  }

  Future<void> getCategory() async {
    isLoading(true);
    final data = await _categoryApi.getCategories();
    CategoryRes.value = data;
    isLoading(false);
  }

  void toggleCategory(Category category) {
    selectedCategory.value = category;
  }
}
