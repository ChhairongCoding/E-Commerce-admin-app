import 'package:e_commerce_admin_app/services/local/token_service.dart';
import 'package:e_commerce_admin_app/views/home_screen.dart';
import 'package:e_commerce_admin_app/views/show_terms_privacy_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  var selectedIndex = 0.obs;
  var isCheckingToken = true.obs;

  final List<Widget> listPage = [HomeScreen(), ShowTermsPrivacyScreen()];
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
  }

  void checkToken() {
    String? token = tokenService.getToken();
    isCheckingToken.value = false;

    if ((token).isNotEmpty) {
      Get.toNamed("/");
    } else {
      Get.toNamed("/signIn");
    }
  }
}
