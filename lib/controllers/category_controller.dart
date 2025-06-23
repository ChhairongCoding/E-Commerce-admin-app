import 'package:e_commerce_admin_app/models/category_model.dart';
import 'package:e_commerce_admin_app/services/category_api.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;

class CategoryController extends GetxController {
  Rx<CategoryResponse> categoryRes = CategoryResponse.empty().obs;
  final isLoading = false.obs;
  final CategoryApi _categoryApi = CategoryApi();
  Rx<CategoryModel> selectedCategory = CategoryModel(productCount: 0).obs;

  List<String> headerTable = [
    'ID',
    'Category Name',
    'Product Count',
    'Status',
    'Action',
  ];

  List<List<dynamic>> rowsTable = [];

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  Future<void> getCategories() async {
    isLoading(true);
    final data = await _categoryApi.getCategories();
    categoryRes.value = data;

    rowsTable = data.data.map((category) {
      return [
        category.id.toString(),
        category.name ?? 'N/A',
        // category.productCount.toString(),
        (category.isActive ?? false) ? 'Active' : 'Inactive',
        '',
      ];
    }).toList();
    isLoading(false);
  }

  void toggleCategory(CategoryModel category) {
    selectedCategory.value = category;
  }

  Future<void> addCategory(
    String name,
    String description,
    String parentCategory,
    bool isActive,
  ) async {
    try {
      isLoading(true);
      await _categoryApi.saveCategory(
        name: name,
        description: description,
        parentCategory: parentCategory,
        isActive: isActive,
      );
      isLoading(false);
      Get.snackbar('Success', 'Category saved successfully');
      getCategories();
    } catch (e) {
      Get.snackbar('Save Failed', 'Category save failed ');
      developer.log("Category error: $e");
    }
  }

  // void clearSelection() {
  //   selectedCategory.value = CategoryModel();
  // }
}
