import 'package:e_commerce_admin_app/controllers/update_add_controller.dart';
import 'package:e_commerce_admin_app/widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:hugeicons/hugeicons.dart';

class UpdateAddScreen extends StatelessWidget {
  UpdateAddScreen({super.key});
  final UpdateAddController updateAddController = Get.put(UpdateAddController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Products", style: TextStyle(fontSize: 30)),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: Form(
                    key: updateAddController.Formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 10,
                      children: [
                        SizedBox(
                          width: size.width,
                          child: CustomTextfieldWidget(
                            hintText: "Input product name",
                            label: "Product Name",
                          ),
                        ),
                        SizedBox(
                          width: size.width,
                          child: CustomTextfieldWidget(
                            hintText: "Input brands",
                            label: "Brands",
                          ),
                        ),
                        SizedBox(
                          width: size.width,
                          child: Row(
                            spacing: 10,
                            children: [
                              Expanded(
                                child: CustomTextfieldWidget(
                                  hintText: "Input stock",
                                  label: "Stock",
                                ),
                              ),
                              Expanded(
                                child: CustomTextfieldWidget(
                                  hintText: "Input Price",
                                  label: "Price",
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton( child: Text("Create"),onPressed: ()=>updateAddController.validateForm())
                      ],
                    ),
                  ),
                ),
                Expanded(child: Text("Hell"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
