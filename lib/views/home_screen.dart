import 'package:e_commerce_admin_app/controllers/home_controller.dart';
import 'package:e_commerce_admin_app/controllers/toggle_mode_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ToggleModeController toggleModeController = Get.find();
  final HomeController homeController = Get.put(HomeController());

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
            height: size.width <= 1200 ? 600 : 300,
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

          Expanded(
            child: ListView(children: [BuildTable(homeController.products)]),
          ),
        ],
      ),
    );
  }

  Column BuildTable(List<Map<String, dynamic>> products) {
    return Column(
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
              ],
            ),
            Divider(height: 30, thickness: 1),

            Obx(() {
              final products = homeController.products;
              return Column(
                children: List.generate(products.length * 2 - 1, (index) {
                  if (index.isEven) {
                    // Even index: product row
                    final product = products[index ~/ 2];
                    return Row(
                      children: [
                        Expanded(
                          child: Image.network(
                            product["image"],
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.image),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            product["ProductName"],
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(child: Text(product["Brand"])),
                        Expanded(child: Text("${product["Stock"]}")),
                        Expanded(child: Text("\$${product["Price"]}")),
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
      final categoryCount = homeController.categories.length;

      return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isDark ? Colors.white : Color(0xff012B43),
          borderRadius: BorderRadius.circular(15),
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
                    fontSize: size.width < 1200 ? 40 : 60,
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
