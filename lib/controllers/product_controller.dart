import 'package:e_commerce_admin_app/models/product_model.dart';
import 'package:e_commerce_admin_app/services/product_api.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  ProductApi productApi = ProductApi();
  List<Product> products = <Product>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProducts();
  }

  Future<void> getProducts() async {
    final res = await productApi.fetchAllProducts();
    products.addAll(res);
    print(products);
  }
}
