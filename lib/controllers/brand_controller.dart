import 'package:e_commerce_admin_app/controllers/product_controller.dart';
import 'package:e_commerce_admin_app/models/brand_model.dart';
import 'package:e_commerce_admin_app/services/brand_service.dart';
import 'package:get/get.dart';
class BrandController extends GetxController {
  final ProductController productController = Get.find<ProductController>();

  Rx<BrandResponse> brandRes = BrandResponse.empty().obs;
  final isLoading = false.obs;
  final BrandService _brandService = BrandService();
  Rx<BrandModel> selectedBrand = BrandModel().obs;
  @override
  void onInit() {
    super.onInit();
    getBrands();
  }

  
  List<String> headerTable = [
    'ID',
    'Brandd Name',
    'Product Count',
    'Action',
  ];

  Future<void> getBrands() async {
    isLoading(true);
    final data = await _brandService.getBrands();
    brandRes.value = data;
    isLoading(false);
  }

  void toggleBrand(BrandModel brand) {
    selectedBrand.value = brand;
  }
}
