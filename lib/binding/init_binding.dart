import 'package:e_commerce_admin_app/controllers/brand_controller.dart';
import 'package:e_commerce_admin_app/controllers/category_controller.dart';
import 'package:e_commerce_admin_app/controllers/home_controller.dart';
import 'package:e_commerce_admin_app/controllers/main_controller.dart';
import 'package:e_commerce_admin_app/controllers/product_controller.dart';
import 'package:e_commerce_admin_app/controllers/sign_in_controller.dart';
import 'package:e_commerce_admin_app/controllers/sign_up_controller.dart';
import 'package:e_commerce_admin_app/controllers/toggle_mode_controller.dart';
import 'package:e_commerce_admin_app/controllers/update_add_controller.dart';
import 'package:e_commerce_admin_app/services/auth_api.dart';
import 'package:e_commerce_admin_app/services/local/token_service.dart';
import 'package:get/get.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthApi());
    Get.put(MainController());
    Get.put(HomeController());
    Get.put(ProductController());
    Get.put(() => ToggleModeController(),permanent: true);
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(TokenService());
    Get.put(UpdateAddController());
    Get.put(BrandController());
    Get.put(CategoryController());
  }
}
