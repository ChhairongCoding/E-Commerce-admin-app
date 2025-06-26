import 'package:e_commerce_admin_app/views/brand-views/main_brand_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class MainBrandScreen extends StatelessWidget {
  const MainBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainBrandController mainBrandController =
        Get.find<MainBrandController>();
    return Obx(() {
      final currentIndex = mainBrandController.currentIndex.value;
      return mainBrandController.brandScreen[currentIndex];
    });
  }
}
