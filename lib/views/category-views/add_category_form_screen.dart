import 'package:e_commerce_admin_app/controllers/category_controller.dart';
import 'package:e_commerce_admin_app/widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class AddCategoryFormScreen extends StatelessWidget {
  AddCategoryFormScreen({super.key});

  final categoryNameController = TextEditingController();
  final categoryDescriptionController = TextEditingController();
  final parentCategoryController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final RxBool isActive = true.obs;

  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController =
        Get.find<CategoryController>();

    return SingleChildScrollView(
      child: Container(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(HugeIcons.strokeRoundedArrowLeft01),
                  ),
                  Text(
                    "Add Category",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    CustomTextfieldWidget(
                      controller: categoryNameController,
                      hintText: "Enter Category Name",
                      label: "Category Name",
                      validator: (value) {
                        if (value!.isEmpty)
                          return "Please enter a category name";
                        return null;
                      },
                    ),
                    CustomTextfieldWidget(
                      controller: categoryDescriptionController,
                      hintText: "Enter Description",
                      label: "Description",
                      maxLines: 4,
                      validator: (value) {
                        if (value!.isEmpty) return "Please enter a description";
                        return null;
                      },
                    ),
                    CustomTextfieldWidget(
                      controller: parentCategoryController,
                      hintText: "Enter Parent Category (optional)",
                      label: "Parent Category",
                    ),
                    Obx(
                      () => SwitchListTile(
                        title: Text("Is Active"),
                        value: isActive.value,
                        onChanged: (val) => isActive.value = val,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4,
                        ),
                        child: Text(
                          "Save Category",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            categoryController.addCategory(
                              categoryNameController.text.trim(),
                              categoryDescriptionController.text.trim(),
                              parentCategoryController.text.trim(),
                              isActive.value,
                            );
                            Get.back();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
