import 'package:e_commerce_admin_app/models/category_model.dart';
import 'package:e_commerce_admin_app/services/category_api.dart';
import 'package:e_commerce_admin_app/views/category-views/main_category_controller.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;

class CategoryController extends GetxController {
  final isLoading = false.obs;
  final isUpdate = false.obs;
  final updateId ="".obs;
  
  final CategoryApi categoryApi = CategoryApi();
  Rx<CategoryModel> selectedCategory = CategoryModel().obs;
  Rx<CategoryResponse> categoryRes = CategoryResponse.empty().obs;


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
    final data = await categoryApi.getCategories();
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
      await categoryApi.saveCategory(
        name: name,
        description: description,
        // parentCategory: parentCategory,
        isActive: isActive,
      );
      isLoading(false);
      getCategories();
    } catch (e) {
      developer.log("Category error: $e");
    }
    isLoading(false);
  }

  void removeCategory (String id){
    updateId(id);
    isLoading(true);
    categoryApi.removeCategory(id);
    final categories = categoryRes.value.data;
    categories.removeWhere((p) => p.id == id);
    categoryRes.refresh();
    isLoading(false);

  }


  void onEditCategoryTap(String id){
     final category = categoryRes.value.data.firstWhere(
      (e) => e.id == id,
      orElse: () => CategoryModel(),
    );

    if(category.id != null){
      selectedCategory.value = category;
    }
      
    isUpdate(true);
    Get.find<MainCategoryController>().toggleSwitch(1); 
  }

  void updateCategory(String id,String name,String description,bool isActive) {
    isLoading(true);
    categoryApi.updateCategory(id, name, description, isActive);
    isLoading(false);
  }
}