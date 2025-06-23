import 'package:e_commerce_admin_app/views/category-views/main_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';



class MainCategoryScreen extends StatelessWidget {
  const MainCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainCategoryController mainCategoryController = Get.find<MainCategoryController>();
    return Obx(() {
      final currentIndex = mainCategoryController.currentIndex.value;
      return mainCategoryController.mainCategories[currentIndex];
    });
  }
}
