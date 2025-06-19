import 'package:e_commerce_admin_app/controllers/category_controller.dart';
import 'package:e_commerce_admin_app/controllers/product_controller.dart';
import 'package:e_commerce_admin_app/controllers/toggle_mode_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:get/instance_manager.dart' as img;

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ToggleModeController toggleModeController = Get.find();
  final CategoryController categoryController = Get.put(CategoryController());
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fixed height, non-scrollable grid
          SizedBox(
            height: size.width <= 1200 ? 600 : 200,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: size.width <= 600
                    ? 1
                    : size.width <= 1200
                    ? 2
                    : 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2,
              ),
              itemCount: 3,
              itemBuilder: (context, index) => buildCard(size, index),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(Size size, int index) {
    return Obx(() {
      final isDark = toggleModeController.isDarkMode.value;
      final CategoryController categoryController = Get.put(
        CategoryController(),
      );
      final ProductController productController = Get.put(ProductController());
      final categoriesRes = categoryController.categoryRes();
      final productsRes = productController.productRes();
      return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isDark
              ? const Color.fromARGB(255, 233, 233, 233)
              : Color(0xff012B43),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color.fromARGB(255, 190, 190, 190)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // Show only the category name for this card index
                  "${categoriesRes.data.isNotEmpty && index < categoriesRes.data.length ? categoriesRes.data[index].name : ''}",
                  style: TextStyle(
                    fontSize: size.width < 1200 ? 35 : 55,
                    fontWeight: FontWeight.bold,
                    height: 1,
                    color: isDark ? Color(0xff141218) : Colors.white,
                  ),
                ),
                Text(
                  "Products",
                  style: TextStyle(
                    fontSize: size.width < 1200 ? 10 : 15,
                    color: isDark ? Color(0xff141218) : Colors.white60,
                  ),
                ),
                Text(
                  "${productsRes.data?.products.length}",
                  style: TextStyle(
                    fontSize: size.width < 1200 ? 20 : 30,
                    color: isDark ? Color(0xff141218) : Colors.white,
                  ),
                ),
                Text(
                  "This month",
                  style: TextStyle(
                    fontSize: size.width < 1200 ? 10 : 15,
                    color: isDark ? Color(0xff141218) : Colors.white60,
                  ),
                ),
              ],
            ),
            // Right icon
            Icon(
              HugeIcons.strokeRoundedChartLineData03,
              color: isDark ? Color(0xff141218) : Colors.white60,
              size: size.width * 0.06,
            ),
          ],
        ),
      );
    });
  }
}
