import 'package:e_commerce_admin_app/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Obx(() {
          
            final headers = categoryController.headerTable;
            final categories = categoryController.categoryRes.value.data;

            return DataTable(
              columnSpacing: 160,
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
                    DataCell(Text(category.id.toString())),
                    DataCell(Text(category.name ?? 'N/A')),
                    // DataCell(Text(category.productCount.toString())),
                    DataCell(
                      Text(category.isActive == true ? 'Active' : 'Inactive'),
                    ),
                    const DataCell(
                      Row(
                        children: [
                          Icon(Icons.edit, color: Colors.blue),
                          SizedBox(width: 8),
                          Icon(Icons.delete, color: Colors.red),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}
