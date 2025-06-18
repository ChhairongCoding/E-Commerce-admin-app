import 'package:e_commerce_admin_app/controllers/product_controller.dart';
import 'package:e_commerce_admin_app/views/product-views/main_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:hugeicons/hugeicons.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});
  final RxBool isChecked = false.obs;
  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Products", style: TextStyle(fontSize: 30)),
                Row(
                  spacing: 10,
                  children: [
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white38),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(HugeIcons.strokeRoundedFileExport),
                            SizedBox(width: 10),
                            Text("Export"),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white38),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(HugeIcons.strokeRoundedPrinter),
                            SizedBox(width: 10),
                            Text("Print"),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Get.dialog(
                        //   Dialog(
                        //     child: CustomFormWidget(),
                        //   )
                        // );
                        Get.find<MainProductController>().toggleSwitch(1);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          border: Border.all(color: Colors.white38),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(HugeIcons.strokeRoundedAdd01),
                            SizedBox(width: 10),
                            Text("Create Product"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 400,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Search anything...",
                      prefixIcon: Icon(HugeIcons.strokeRoundedSearch01),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Divider(height: 1, thickness: 1.1),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
