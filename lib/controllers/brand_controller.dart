import 'package:e_commerce_admin_app/models/brand_model.dart';
import 'package:e_commerce_admin_app/services/brand_service.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  Rx<BrandResponse> brandRes = BrandResponse.empty().obs;
  final isLoading = false.obs;
  final BrandService _brandService = BrandService();
  Rx<Brand> selectedBrand = Brand.empty().obs;
  @override
  void onInit() {
    super.onInit();
    getBrands();
  }

  Future<void> getBrands() async {
    isLoading(true);
    final data = await _brandService.getBrands();
    brandRes.value = data;
    isLoading(false);
  }

  void toggleBrand(Brand brand) {
    selectedBrand.value = brand;
  }
}
