import 'package:e_commerce_admin_app/controllers/toggle_mode_controller.dart';
import 'package:e_commerce_admin_app/services/local/token_service.dart';
import 'package:e_commerce_admin_app/views/category-views/main_category_controller.dart';
import 'package:e_commerce_admin_app/views/category-views/main_category_screen.dart';
import 'package:e_commerce_admin_app/views/product-views/main_product_controller.dart';
import 'package:e_commerce_admin_app/views/product-views/main_product_screen.dart';
import 'package:e_commerce_admin_app/views/brand_screen.dart';
import 'package:e_commerce_admin_app/views/home_screen.dart';
import 'package:e_commerce_admin_app/views/sell_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final ToggleModeController toggleModeController = Get.put(
    ToggleModeController(),
  );


  var selectedIndex = 0.obs;
  var isCheckingToken = true.obs;

  final List<Widget> listPage = [
    HomeScreen(),
    MainProductScreen(),
    MainCategoryScreen(),
    BrandScreen(),
    SellScreen(),
  ];

  TokenService tokenService = TokenService();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkToken();
    });
  }

  void changeIndex(int index) {
    selectedIndex.value = index;

    if(index == 0){}
    else if(index == 1){
      Get.find<MainProductController>().toggleSwitch(0);
    }
    else if(index == 2){
      Get.find<MainCategoryController>().toggleSwitch(0);
    }
  }


  void checkToken() {
    isCheckingToken.value = false;
    String? token = tokenService.getToken();
    if ((token).isNotEmpty) {
      Get.toNamed("/");
    } else {
      Get.toNamed("/signIn");
    }
  }

  void signOut() {
    Get.dialog(
      AlertDialog(
        title: Text("Sign Out"),
        content: Text("Are you sure you want to sign out?"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              tokenService.clearToken();
              toggleModeController.isDarkMode.value = false;
              Get.offAllNamed('signIn');
            },
            child: Text("Sign Out"),
          ),
        ],
      ),
    );
  }
}
