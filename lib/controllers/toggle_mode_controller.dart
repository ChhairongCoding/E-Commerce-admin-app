import 'package:e_commerce_admin_app/services/store_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ToggleModeController extends GetxController {
  RxBool isDarkMode= false.obs;
  ThemeData get currentTheme => isDarkMode.value ? ThemeData.dark() : ThemeData.light();
  final StoreTheme storeTheme = StoreTheme();
  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = storeTheme.loadTheme();
  }

  void toggleTheme(){
    isDarkMode.value = !isDarkMode.value;
    storeTheme.themCheck(isDarkMode);

  }
}
