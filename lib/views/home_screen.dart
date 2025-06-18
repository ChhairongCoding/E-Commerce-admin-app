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
              itemBuilder: (context, index) => buildCard(size),
            ),
          ),

          Expanded(child: ListView(children: [buildTable()])),
        ],
      ),
    );
  }

  Column buildTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Top selling products", style: TextStyle(fontSize: 20)),
        Column(
          children: [
            Divider(height: 30, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "SNO:01",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Product Name",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Brands",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Stock",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Price",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Action",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Divider(height: 30, thickness: 1),

            Obx(() {
              // final productRes = productController.productRes.value;
              final products = productController.productRes.value.products;
              return Column(
                children: List.generate(products.length, (index) {
                  if (index.isEven) {
                    final product = products[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.network(
                            product.images.first.url ??
                                "https://icons.veryicon.com/png/o/application/applet-1/product-17.png",
                            height: 50,
                            width: 50,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${product.name}",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(child: Text("${product.brand}")),
                        Expanded(child: Text("${product.stock}")),
                        Expanded(child: Text("\$${product.price}")),
                        Expanded(
                          child: Row(
                            spacing: 10,
                            children: [Text("Edit"), Text("Delete")],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Divider(height: 30, thickness: 1);
                  }
                }),
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget buildCard(Size size) {
    return Obx(() {
      final isDark = toggleModeController.isDarkMode.value;
      final categoryCount = categoryController.CategoryRes;
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
                  "$categoryCount",
                  style: TextStyle(
                    fontSize: size.width < 1200 ? 35 : 55,
                    fontWeight: FontWeight.bold,
                    height: 1,
                    color: isDark ? Color(0xff141218) : Colors.white,
                  ),
                ),
                Text(
                  "Total Categories",
                  style: TextStyle(
                    fontSize: size.width < 1200 ? 10 : 15,
                    color: isDark ? Color(0xff141218) : Colors.white60,
                  ),
                ),
                Text(
                  "1",
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
