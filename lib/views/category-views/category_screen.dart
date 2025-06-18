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
          child: DataTable(
            columnSpacing: 180,
            columns: List.generate(
              categoryController.headerTable.length,
              (index) => DataColumn(
                label: Text(
                  categoryController.headerTable[index],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            rows: List.generate(categoryController.rowsTable.length, (
              rowIndex,
            ) {
              return DataRow(
                cells: List.generate(categoryController.headerTable.length, (
                  colIndex,
                ) {
                  // If this is the Action column
                  if (categoryController.headerTable[colIndex].toLowerCase() ==
                      'action') {
                    return DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              // TODO: implement edit action
                              print('Edit row $rowIndex');
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // TODO: implement delete action
                              print('Delete row $rowIndex');
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    // Regular data cell
                    return DataCell(
                      Text(
                        categoryController.rowsTable[rowIndex][colIndex]
                            .toString(),
                      ),
                    );
                  }
                }),
              );
            }),
          ),
        ),
      ),
    );
  }
}
