import 'package:e_commerce_admin_app/views/category-views/add_category_form_screen.dart';
import 'package:e_commerce_admin_app/views/category-views/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainCategoryController extends GetxController {
  RxList<Widget> mainCategories = <Widget>[
    CategoryScreen(),
    AddCategoryFormScreen(),
  ].obs;

  RxInt currentIndex = 0.obs;

  void toggleSwitch(int index) {
    currentIndex.value = index;
  }
}
