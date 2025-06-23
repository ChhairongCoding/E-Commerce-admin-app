import 'package:e_commerce_admin_app/controllers/category_controller.dart';
import 'package:e_commerce_admin_app/controllers/product_controller.dart';
import 'package:e_commerce_admin_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

class DropdownMenuCategoryWidget extends StatelessWidget {
  final bool isUpdate;
  const DropdownMenuCategoryWidget({super.key, this.isUpdate = false});

  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController =
        Get.find<CategoryController>();
    final ProductController productController = Get.find<ProductController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select a Category",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Obx(() {
          final categories = categoryController.categoryRes.value.data ?? [];
          final currentCategoryId = productController.categoryId.value;

          if (categoryController.isLoading.value) {
            return const LinearProgressIndicator();
          }

          CategoryModel? initialValue;
          if (isUpdate && currentCategoryId != null) {
            initialValue = categories.firstWhere(
              (b) => b.id == currentCategoryId,
              orElse: () => CategoryModel(), // Default to empty BrandModel
            );
            // Sync selectedBrand only if different
            if (categoryController.selectedCategory.value.id !=
                initialValue.id) {
              categoryController.toggleCategory(initialValue);
            }
          } else {
            initialValue = categoryController.selectedCategory.value;
          }

          return categoryController.isLoading.value
              ? LinearProgressIndicator()
              : DropdownButtonFormField<CategoryModel>(
                  value:
                      initialValue.id != null &&
                          categories.any((b) => b.id == initialValue!.id)
                      ? categories.firstWhere((b) => b.id == initialValue!.id)
                      : null,
                  hint: const Text("Choose a Category"),
                  items: categories.map((CategoryModel category) {
                    return DropdownMenuItem<CategoryModel>(
                      value: category,
                      child: Text(category.name ?? "No Category"),
                    );
                  }).toList(),
                  onChanged: (CategoryModel? value) {
                    if (value != null) {
                      categoryController.toggleCategory(value);
                      productController.categoryId.value = value.id;
                    }
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
