import 'package:e_commerce_admin_app/views/product-views/main_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class MainProductScreen extends StatelessWidget {
  const MainProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainProductController mainProductController = Get.find<MainProductController>();
    return Obx((){
      final currentIndex = mainProductController.currentIndex.value;
      return mainProductController.mainProducts[currentIndex];
    });
  }
}