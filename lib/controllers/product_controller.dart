import 'package:e_commerce_admin_app/models/product_model.dart';
import 'package:e_commerce_admin_app/services/product_api.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  ProductApi productApi = ProductApi();
  List<Product> products = <Product>[].obs;
  List<ProductImage> imageList = <ProductImage>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProducts();
    getProductsImage();
  }

  Future<void> getProducts() async {
    final res = await productApi.fetchAllProducts();
    products.addAll(res);
    print("product : ${products}");
  }

  Future<void> getProductsImage() async {
    final res = await productApi.fetchImageProduct();
    imageList.addAll(res);
    print("image: ${imageList}");
  }
}
