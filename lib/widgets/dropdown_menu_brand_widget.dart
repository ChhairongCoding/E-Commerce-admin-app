import 'package:e_commerce_admin_app/controllers/brand_controller.dart';
import 'package:e_commerce_admin_app/controllers/product_controller.dart';
import 'package:e_commerce_admin_app/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropdownMenuBrandWidget extends StatelessWidget {
  final bool isUpdate;

  const DropdownMenuBrandWidget({super.key, this.isUpdate = false});

  @override
  Widget build(BuildContext context) {
    final BrandController brandController = Get.find<BrandController>();
    final ProductController productController = Get.find<ProductController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select a Brand",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Obx(() {
          final brands = brandController.brandRes.value.data ?? [];
          final currentBrandId = productController.brandId.value;

          if (brandController.isLoading.value) {
            return const LinearProgressIndicator();
          }

          BrandModel? initialValue;
          if (isUpdate && currentBrandId != null) {
            initialValue = brands.firstWhere(
              (b) => b.id == currentBrandId,
              orElse: () => BrandModel(), // Default to empty BrandModel
            );
            // Sync selectedBrand only if different
            if (brandController.selectedBrand.value.id != initialValue.id) {
              brandController.toggleBrand(initialValue);
            }
          } else {
            initialValue = brandController.selectedBrand.value;
          }

          // Log for debugging
          print('Dropdown initialValue: $initialValue');

          return DropdownButtonFormField<BrandModel>(
            value: initialValue.id != null && brands.any((b) => b.id == initialValue!.id)
                ? brands.firstWhere((b) => b.id == initialValue!.id )
                : null,
            hint: const Text("Choose a brand"),
            items: brands.map((BrandModel brand) {
              return DropdownMenuItem<BrandModel>(
                value: brand,
                child: Text(brand.name ?? ''),
              );
            }).toList(),
            onChanged: (BrandModel? value) {
              if (value != null) {
                brandController.toggleBrand(value);
                productController.brandId.value = value.id;
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