import 'package:e_commerce_admin_app/controllers/category_controller.dart';
import 'package:e_commerce_admin_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

class DropdownMenuCategoryWidget extends StatelessWidget {
  const DropdownMenuCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController = Get.put(CategoryController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select a Category",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Obx(() {
          final selectedCategory = categoryController.selectedCategory;
          final categories = categoryController.categoryRes.value.data;
          return categoryController.isLoading.value
              ? LinearProgressIndicator()
              : DropdownButtonFormField<Category>(
                  value: categories.any((b) => b == selectedCategory.value)
                      ? selectedCategory.value
                      : null,
                  hint: const Text("Choose a Category"),
                  items: categories.map((Category category) {
                    return DropdownMenuItem<Category>(
                      value: category,
                      child: Text(category.name ?? "No Category"),
                    );
                  }).toList(),
                  onChanged: (Category? value) {
                    categoryController.toggleCategory(
                      value ?? Category.empty(),
                    );
                    print("cc $value");
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                );
        }),
      ],
    );
  }
}
