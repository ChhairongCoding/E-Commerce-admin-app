import 'package:e_commerce_admin_app/services/category_api.dart';
import 'package:get/get.dart';
import 'package:e_commerce_admin_app/models/category_model.dart';

class HomeController extends GetxController {
  RxList<Category> categories = <Category>[].obs;
  final CategoryApi categoryApi = CategoryApi();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchProducts();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await categoryApi.getCategory();
      categories.addAll(response.cast<Category>());
      print('Fetched ${categories.length} categories.');
    } catch (e) {
      print('Failed to fetch categories: $e');
    }
  }

  // 🟢 Define the observable list of products
  var products = <Map<String, dynamic>>[].obs;

  void fetchProducts() {
    // 🟢 This simulates an API call (replace it with real one later)
    products.value = [
      {
        "image": "https://via.placeholder.com/50",
        "ProductName": "Brand New Product 1",
        "Brand": "Helepo",
        "Stock": 20,
        "Price": 20,
      },
      {
        "image": "https://via.placeholder.com/50",
        "ProductName": "Brand New Product 2",
        "Brand": "Helepo",
        "Stock": 15,
        "Price": 25,
      },
      {
        "image": "https://via.placeholder.com/50",
        "ProductName": "Brand New Product 3",
        "Brand": "Helepo",
        "Stock": 10,
        "Price": 30,
      },
      {
        "image": "https://via.placeholder.com/50",
        "ProductName": "Brand New Product 3",
        "Brand": "Helepo",
        "Stock": 10,
        "Price": 30,
      },
    ];
  }
}
