import 'package:e_commerce_admin_app/views/product-views/main_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:hugeicons/hugeicons.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});
  final RxBool isChecked = false.obs;
  
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
                      onTap: (){
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
            Obx(
              () => SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Product Info",
                              style: TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Product Name",
                              style: TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Price",
                              style: TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Stock",
                              style: TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          Expanded(
                            child: Text(
                              "Active",
                              style: TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(height: 15, thickness: 1.1),
                    SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Checkbox(
                            value: isChecked.value,
                            onChanged: (value) {
                              isChecked.value = value ?? false;
                            },
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Image",
                                  style: TextStyle(fontSize: 15),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "ID: Idad1234",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Keyboard 60 percent 60% mechanical keyboard",
                              style: TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "19.22",
                              style: TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "100",
                              style: TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          Expanded(
                            child: ToggleButtons(
                              isSelected: [true, false],
                              onPressed: (int index) {},
                              borderRadius: BorderRadius.circular(8),
                              constraints: BoxConstraints(
                                minHeight: 36,
                                minWidth: 36,
                              ),
                              children: [
                                Icon(Icons.edit, size: 18),
                                Icon(Icons.delete, size: 18),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 15, thickness: 1.1),
                    SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: isChecked.value,
                            onChanged: (value) {
                              isChecked.value = value ?? false;
                            },
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Image",
                                  style: TextStyle(fontSize: 15),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "ID: Idad1234",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Roting Mouse",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "289.99",
                              style: TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "200",
                              style: TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          Expanded(
                            child: ToggleButtons(
                              isSelected: [true, false],
                              onPressed: (int index) {},
                              borderRadius: BorderRadius.circular(8),
                              constraints: BoxConstraints(
                                minHeight: 36,
                                minWidth: 36,
                              ),
                              children: [
                                Icon(Icons.edit, size: 18),
                                Icon(Icons.delete, size: 18),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
