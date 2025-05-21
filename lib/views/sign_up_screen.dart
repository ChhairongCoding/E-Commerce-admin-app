import 'package:e_commerce_admin_app/controllers/sign_up_controller.dart';
import 'package:e_commerce_admin_app/widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 1),
                          color: Colors.grey.shade100,
                          blurRadius: 5,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    width: size.width * 0.5,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      left: 150,
                      right: 150,
                      top: 20,
                      bottom: 20,
                    ),
                    child: buildMobile(signUpController: signUpController),
                  );
                }
                return buildMobile(signUpController: signUpController);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class buildMobile extends StatelessWidget {
  const buildMobile({super.key, required this.signUpController});

  final SignUpController signUpController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Create Account!",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 38,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Please Create Your Account To Get Inside!",
          style: TextStyle(fontSize: 15, height: 1.5),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Form(
            child: Column(
              children: [
                Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Full Name", style: TextStyle(fontSize: 14)),
                    CustomTextfieldWidget(hintText: "Full Name"),
                  ],
                ),
                SizedBox(height: 25),
                SizedBox(
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email Address", style: TextStyle(fontSize: 14)),
                      CustomTextfieldWidget(hintText: "Enter email"),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                SizedBox(
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Password", style: TextStyle(fontSize: 14)),
                      CustomTextfieldWidget(hintText: "Enter Password"),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                SizedBox(
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Confirm Password", style: TextStyle(fontSize: 14)),
                      CustomTextfieldWidget(hintText: "Confirm Password"),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: signUpController.isChecked.value,
                        onChanged: (bool? newValue) {
                          signUpController.isChecked.value = newValue ?? false;
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed("/showTermsAndPrivacy"),
                      child: Row(
                        children: [
                          Text("Read the "),
                          Text(
                            "Terms and Privacy",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Color(0xff012B43),
                    minimumSize: Size(double.infinity, 60),
                  ),
                  child: Text("Sign In", style: TextStyle(color: Colors.white)),
                  onPressed: () {},
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have an account!"),
                    TextButton(
                      onPressed: () => Get.toNamed("/"),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
