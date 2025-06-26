import 'package:e_commerce_admin_app/controllers/category_controller.dart';
import 'package:e_commerce_admin_app/views/category-views/main_category_controller.dart';
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
    final category = categoryController.selectedCategory.value;

    if (categoryController.isUpdate.value) {
      categoryNameController.text = category.name ?? '';
      categoryDescriptionController.text = category.description ?? '';
      isActive.value = category.isActive ?? true;
    }

    return SingleChildScrollView(
      child: categoryController.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : SizedBox(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.find<MainCategoryController>().toggleSwitch(0);
                              categoryNameController.text ='';
                                  categoryDescriptionController.text ='';
                          },
                          icon: Icon(HugeIcons.strokeRoundedArrowLeft01),
                        ),
                        Text(
                          categoryController.isUpdate.value
                              ? "Update Category"
                              : "Add Category",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        spacing: 20,
                        children: [
                          CustomTextfieldWidget(
                            controller: categoryNameController,
                            hintText: "Enter Category Name",
                            label: "Category Name",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter a category name";
                              }
                              return null;
                            },
                          ),
                          CustomTextfieldWidget(
                            controller: categoryDescriptionController,
                            hintText: "Enter Description",
                            label: "Description",
                            maxLines: 4,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter a description";
                              }
                              return null;
                            },
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
                                categoryController.isUpdate.value
                                    ? "Update Category"
                                    : "Save Category",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  categoryController.isUpdate.value
                                      ? categoryController.updateCategory(
                                          category.id.toString(),
                                          categoryNameController.text.trim(),
                                          categoryDescriptionController.text
                                              .trim(),
                                          isActive.value,
                                        )
                                      : categoryController.addCategory(
                                          categoryNameController.text.trim(),
                                          categoryDescriptionController.text
                                              .trim(),
                                          parentCategoryController.text.trim(),
                                          isActive.value,
                                        );

                                  // Get.back();
                                  categoryNameController.text ='';
                                  categoryDescriptionController.text ='';
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
