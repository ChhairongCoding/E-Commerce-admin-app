import 'package:e_commerce_admin_app/services/product_api.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var tabIndex = 0.obs;
  final  
  ProductApi productApi = ProductApi();
  @override
  void onInit() {
   
    super.onInit();
  }
}
