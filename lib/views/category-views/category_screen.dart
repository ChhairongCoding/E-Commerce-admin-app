import 'package:e_commerce_admin_app/controllers/category_controller.dart';
import 'package:e_commerce_admin_app/views/category-views/main_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          spacing: 15,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categories", style: TextStyle(fontSize: 30)),
                Row(
                  spacing: 10,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement export functionality
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
                        // TODO: Implement print functionality
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
                      label: Text("Create Category"),
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
                        Get.find<MainCategoryController>().toggleSwitch(1);
                      },
                    ),
                  ],
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() {
                final headers = categoryController.headerTable;
                final categories = categoryController.categoryRes.value.data;

                return DataTable(
                  columnSpacing: 140,
                  columns: headers
                      .map(
                        (header) => DataColumn(
                          label: Text(
                            header,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  rows: List.generate(categories.length, (rowIndex) {
                    final category = categories[rowIndex];

                    return DataRow(
                      cells: [
                        DataCell(Text("ID ${rowIndex + 1}")),
                        DataCell(Text(category.name ?? 'N/A')),
                        DataCell(Text(category.productCount.toString())),
                        DataCell(
                          Text(
                            category.isActive == true ? 'Active' : 'Inactive',
                          ),
                        ),
                        DataCell(
                          Row(
                            spacing: 8,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () => {
                                  categoryController.onEditCategoryTap(category.id!)
                                },
                                label: Icon(HugeIcons.strokeRoundedEdit01),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  categoryController.removeCategory(category.id.toString());
                                },
                                label: Icon(HugeIcons.strokeRoundedDelete01),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
