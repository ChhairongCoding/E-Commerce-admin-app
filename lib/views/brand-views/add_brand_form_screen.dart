import 'dart:typed_data';

import 'package:e_commerce_admin_app/controllers/brand_controller.dart';
import 'package:e_commerce_admin_app/views/brand-views/main_brand_controller.dart';
import 'package:e_commerce_admin_app/widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class AddBrandFormScreen extends StatelessWidget {
  AddBrandFormScreen({super.key});
  final TextEditingController brandNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final BrandController brandController = Get.put(BrandController());

    return SingleChildScrollView(
      child: Container(
        child: Form(
          key: brandController.formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Left Column: Form Fields
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Back Button and Title
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios_new),
                            onPressed: () {
                              Get.find<MainBrandController>().toggleSwitch(0);
                            },
                          ),
                          Text(
                            "Create Brand",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      /// Brand Name Field
                      CustomTextfieldWidget(
                        controller: brandNameController,
                        hintText: "Enter Brand Name",
                        label: "Brand Name",
                        validator: (value) {
                          if (value!.isEmpty) return "Please enter brand name";
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      /// Description Field
                      CustomTextfieldWidget(
                        controller: descriptionController,
                        hintText: "Enter Description",
                        label: "Description",
                        maxLines: 4,
                        validator: (value) {
                          if (value!.isEmpty) return "Please enter description";
                          return null;
                        },
                      ),
                      SizedBox(height: 30),

                      /// Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "Add Brand",
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            final brandName = brandNameController.text.trim();
                            final description = descriptionController.text
                                .trim();
                            final image = brandController.imageBytes;

                            if (brandController.formKey.currentState!
                                .validate()) {
                              brandController.addBrand(
                                brandName,
                                description,
                                image as Uint8List,
                              );
                              Get.back();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 30),

                /// Right Column: Upload Image
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Brand Logo", style: TextStyle(fontSize: 20)),
                      SizedBox(height: 16),

                      Obx(
                        () => brandController.imageBytes.isNotEmpty
                            ? Stack(
                                children: [
                                  Container(
                                    width: 180,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      border: DashedBorder.all(
                                        dashLength: 10,
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Image.memory(
                                      brandController.imageBytes.first,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        // => brandController.clearImage()
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : GestureDetector(
                                onTap: () {
                                  // => brandController.pickImage()
                                },
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Icon(
                                    Icons.image_outlined,
                                    size: 60,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "You can upload 1 logo image.",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
