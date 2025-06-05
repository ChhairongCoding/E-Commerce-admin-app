import 'package:e_commerce_admin_app/views/product-views/main_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:hugeicons/hugeicons.dart';

class AddProductFormScreen extends StatelessWidget {
  const AddProductFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Form(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.find<MainProductController>().toggleSwitch(0);
                  },
                  icon: Icon(HugeIcons.strokeRoundedArrowLeft01),
                ),
                Center(child: Text("Create form")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
