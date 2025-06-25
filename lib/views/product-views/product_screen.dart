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
                    ElevatedButton.icon(
                      onPressed: () {
                       
                      },
                      icon: Icon(HugeIcons.strokeRoundedFileExport),
                      label: Text("Export"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        side: BorderSide(color: Colors.white38),
                        elevation: 0,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                     
                      },
                      icon: Icon(HugeIcons.strokeRoundedPrinter),
                      label: Text("Print"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        side: BorderSide(color: Colors.white38),
                        elevation: 0,
                      ),
                    ),
                    ElevatedButton.icon(
                    
                      icon: Icon(HugeIcons.strokeRoundedAdd01),
                      label: Text("Create Product"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        side: BorderSide(color: Colors.white38),
                        elevation: 0,
                      ),
                        onPressed: () {
                        Get.find<MainProductController>().toggleSwitch(1);
                      },
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
            Expanded(child: ListView(children: [buildTable()])),
          ],
        ),
      ),
    );
  }

  Column buildTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          final products =
              productController.productRes.value.data?.products ?? [];
          if (productController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 70,
              columns: const [
                DataColumn(
                  label: Text(
                    'SNO',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Product Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Brands',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Stock',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Price',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Action',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: List<DataRow>.generate(products.length, (index) {
                final product = products[index];
                return DataRow(
                  cells: [
                    DataCell(Text("SNO: ${index + 1}")),
                    DataCell(Text(product.name ?? '')),
                    DataCell(Text(product.brand?.name ?? '')),
                    DataCell(Text("${product.stock}")),
                    DataCell(Text("\$${product.price}")),
                    DataCell(
                      Row(
                        spacing: 8,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              productController.onEditProductTap(product.id!);
                            },
                            label: Icon(HugeIcons.strokeRoundedEdit01),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => productController.removeProduct(
                              product.id.toString(),
                            ),
                            label: Icon(HugeIcons.strokeRoundedDelete01),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
        }),
      ],
    );
  }
}
