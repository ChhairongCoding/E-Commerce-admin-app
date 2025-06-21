import 'package:e_commerce_admin_app/models/category_model.dart';
import 'package:e_commerce_admin_app/services/category_api.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  Rx<CategoryResponse> categoryRes = CategoryResponse.empty().obs;
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
        category.productCount.toString(),
        (category.isActive ?? false) ? 'Active' : 'Inactive',
        '',
      ];
    }).toList();
    print("$rowsTable");
    isLoading(false);
  }

  void toggleCategory(Category category) {
    selectedCategory.value = category;
  }
}
