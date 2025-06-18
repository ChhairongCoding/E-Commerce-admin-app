import 'package:e_commerce_admin_app/views/product-views/main_product_controller.dart';
import 'package:e_commerce_admin_app/widgets/custom_textfield_widget.dart';
import 'package:e_commerce_admin_app/widgets/dropdown_menu_brand_widget.dart';
import 'package:e_commerce_admin_app/widgets/dropdown_menu_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:hugeicons/hugeicons.dart';

class AddProductFormScreen extends StatelessWidget {
  AddProductFormScreen({super.key});
  final productName = TextEditingController();

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

            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                spacing: 20,
                children: [
                  DropdownMenuBrandWidget(),
                  DropdownMenuCategoryWidget(),
                  CustomTextfieldWidget(
                    hintText: "Product Name",
                    label: "Enter Product Name",
                  ),
                  CustomTextfieldWidget(
                    hintText: "Descrition",
                    label: "Enter Description",
                  ),
                  CustomTextfieldWidget(
                    hintText: "Price",
                    label: "Enter Price",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
