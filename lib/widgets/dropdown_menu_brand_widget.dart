import 'package:e_commerce_admin_app/controllers/brand_controller.dart';
import 'package:e_commerce_admin_app/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

class DropdownMenuBrandWidget extends StatelessWidget {
  const DropdownMenuBrandWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final BrandController brandController = Get.put(BrandController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select a Brand",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Obx(() {
          final selectedBrand = brandController.selectedBrand;
          final brands = brandController.brandRes.value.data;
          return brandController.isLoading.value
              ? LinearProgressIndicator()
              : DropdownButtonFormField<Brand>(
                  value: brands.any((b) => b == selectedBrand.value)
                      ? selectedBrand.value
                      : null,
                  hint: const Text("Choose a brand"),
                  items: brands.map((Brand brand) {
                    return DropdownMenuItem<Brand>(
                      value: brand,
                      child: Text(brand.name ?? "No Brand"),
                    );
                  }).toList(),
                  onChanged: (Brand? value) {
                    brandController.toggleBrand(value ?? Brand.empty());
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
