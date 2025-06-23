import 'package:e_commerce_admin_app/controllers/brand_controller.dart';
import 'package:e_commerce_admin_app/controllers/category_controller.dart';
import 'package:e_commerce_admin_app/controllers/product_controller.dart';
import 'package:e_commerce_admin_app/views/product-views/main_product_controller.dart';
import 'package:e_commerce_admin_app/widgets/custom_textfield_widget.dart';
import 'package:e_commerce_admin_app/widgets/dropdown_menu_brand_widget.dart';
import 'package:e_commerce_admin_app/widgets/dropdown_menu_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class UpdateProductFormScreen extends StatelessWidget {
  UpdateProductFormScreen({super.key});
  final productNameController = TextEditingController();
  final descritionController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find();
    final product = productController.selectedProduct.value;
    productNameController.text = product?.name ?? '';
    descritionController.text = product?.description ?? '';
    priceController.text = product?.price.toString() ?? '';
    stockController.text = product?.stock.toString() ?? '';

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(),
        child: Form(
          key: productController.formKey,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.find<MainProductController>().toggleSwitch(0);
                    },
                    icon: Icon(HugeIcons.strokeRoundedArrowLeft01),
                  ),
                  Center(child: Text("Update form")),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        spacing: 20,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownMenuBrandWidget(),
                          DropdownMenuCategoryWidget(),
                          CustomTextfieldWidget(
                            controller: productNameController,
                            hintText: "Enter Product Name",
                            label: "Product Name",
                          ),
                          CustomTextfieldWidget(
                            controller: descritionController,
                            hintText: "Enter Descrition",
                            label: "Description",
                            maxLines: 4,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please input description";
                              }
                              return null;
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextfieldWidget(
                                  controller: priceController,
                                  hintText: "Enter Price",
                                  label: "Price",
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: CustomTextfieldWidget(
                                  controller: stockController,
                                  hintText: "Enter Stock",
                                  label: "Stock",
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 4,
                              ),
                              child: Text(
                                "Add",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                final controller =
                                    Get.find<ProductController>();
                                final brandId = Get.find<BrandController>()
                                    .selectedBrand
                                    .value
                                    .id
                                    .toString();
                                final categoryId =
                                    Get.find<CategoryController>()
                                        .selectedCategory
                                        .value
                                        .id
                                        .toString();

                                final name = productNameController.text.trim();
                                final description = descritionController.text
                                    .trim();
                                final price = priceController.text.trim();
                                final stock = stockController.text.trim();

                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.saveProduct(
                                    brandId: brandId,
                                    categoryId: categoryId,
                                    productName: name,
                                    description: description,
                                    price: price,
                                    stock: stock,
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Input your product images",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              Obx(() {
                                return productController.imageUrls.isNotEmpty
                                    ? Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: List.generate(
                                          productController.imageUrls.length,
                                          (index) {
                                            return Stack(
                                              children: [
                                                Container(
                                                  width: 120,
                                                  height: 120,
                                                  decoration: BoxDecoration(
                                                    border: DashedBorder.all(
                                                      dashLength: 10,
                                                      color: Colors.grey,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                  ),
                                                  child: Image.network(
                                                    productController
                                                        .imageUrls[index],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      )
                                    : productController.filesByte.isNotEmpty
                                    ? Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: List.generate(
                                          productController.filesByte.length,
                                          (index) {
                                            return Stack(
                                              children: [
                                                Container(
                                                  width: 120,
                                                  height: 120,
                                                  decoration: BoxDecoration(
                                                    border: DashedBorder.all(
                                                      dashLength: 10,
                                                      color: Colors.grey,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                  ),
                                                  child: Image.memory(
                                                    productController
                                                        .filesByte[index],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.close,
                                                      size: 20,
                                                    ),
                                                    onPressed: () =>
                                                        productController
                                                            .removeImage(index),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      )
                                    : Container(
                                        width: 200,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.image,
                                          size: 40,
                                          color: Colors.grey[600],
                                        ),
                                      );
                              }),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            "You can add up to 3 images.",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.dialog(
                                AlertDialog(
                                  title: Text("Upload images"),
                                  content: imageDialog(context),
                                  actions: [
                                    ElevatedButton.icon(
                                      icon: Icon(Icons.close),
                                      label: Text("Close"),
                                      onPressed: () {
                                        productController.filesByte.clear();
                                        Get.back();
                                      },
                                    ),
                                    ElevatedButton.icon(
                                      icon: Icon(Icons.save),
                                      label: Text("Save"),
                                      onPressed: () {
                                        productController.isSaved.value = true;
                                        Get.back();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text("Upload Images"),
                          ),
                        ],
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

  Widget imageDialog(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ProductController productController = Get.find<ProductController>();

    return GestureDetector(
      onTap: () => productController.pickerImage(),
      child: Obx(
        () => SizedBox(
          width: size.width * 0.5,
          child: productController.filesByte.isNotEmpty
              ? SingleChildScrollView(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                      productController.filesByte.length,
                      (index) {
                        return Stack(
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                border: DashedBorder.all(
                                  dashLength: 10,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.memory(
                                productController.filesByte[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () =>
                                  productController.removeImage(index),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                )
              : Container(
                  width: size.width * 0.9,
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                    border: DashedBorder.all(
                      dashLength: 10,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.upload_file, size: 80, color: Colors.grey),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Drag and drop or ",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "Browse computer",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
