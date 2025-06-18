import 'package:e_commerce_admin_app/models/product_model.dart';
import 'package:e_commerce_admin_app/services/product_api.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  ProductApi productApi = ProductApi();
  Rx<ProductResponse> productRes = Rx(ProductResponse.empty());
  List<String> colsTable = [
    "Product Info",
    "Product Name",
    "Price",
    "Stock",
    "Action",
  ];

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  Future<void> getProducts() async {
    final res = await productApi.fetchAllProducts();
    productRes.value = res;
  }
}
