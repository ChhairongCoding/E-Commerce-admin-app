import 'package:e_commerce_admin_app/controllers/sign_up_controller.dart';
import 'package:e_commerce_admin_app/controllers/toggle_mode_controller.dart';
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
      backgroundColor: const Color(0xFFF7F7F7),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: LayoutBuilder(
              builder: (context, constraints) {
                double contentWidth = constraints.maxWidth > 600
                    ? size.width * 0.5
                    : double.infinity;

                return Container(
                  width: contentWidth,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 2),
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: buildMobile(signUpController: signUpController),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class buildMobile extends StatelessWidget {
  buildMobile({super.key, required this.signUpController});
  final SignUpController signUpController;
  final ToggleModeController toggleModeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
          "Please create your account to get inside!",
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
        SizedBox(height: 20),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        
                        border: Border.all(color: toggleModeController.isDarkMode.value ? Colors.white:  Colors.black),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/icons/phone.png",
                            height: 45,
                            width: 45,
                          ),
                          SizedBox(width: 20),
                          Flexible(
                            child: Text(
                              "Sign In With Phone",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                    },
                    child: Container(
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        border: Border.all(color: toggleModeController.isDarkMode.value ? Colors.white:  Colors.black),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/icons/google.png",
                            height: 40,
                            width: 40,
                          ),
                          SizedBox(width: 20),
                          Flexible(
                            child: Text(
                              "Sign In With Google",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              spacing: 10,
              children: [
                Expanded(child: Divider(thickness: 1,)),
                Text( "Or Continue With Email", style: TextStyle(fontSize: 15)),
                Expanded(child: Divider(thickness: 1,)),

              ],
            ),
            SizedBox(height: 10),
          ],
        ),
        Form(
          child: Column(
            spacing: 15,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Full Name", style: TextStyle(fontSize: 14)),
                  SizedBox(height:5),
                  CustomTextfieldWidget(hintText: "Full Name"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email Address", style: TextStyle(fontSize: 14)),
                  SizedBox(height:5),
                  CustomTextfieldWidget(hintText: "Enter Email"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Password", style: TextStyle(fontSize: 14)),
                  SizedBox(height: 5),
                  CustomTextfieldWidget(hintText: "Enter Password"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Confirm Password", style: TextStyle(fontSize: 14)),
                  SizedBox(height: 5),
                  CustomTextfieldWidget(hintText: "Confirm Password"),
                ],
              ),
              
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
                           
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Color(0xff012B43),
                  minimumSize: Size(double.infinity, 60),
                ),
                child: Text("Sign Up", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  // Add sign-up logic here
                },
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an account?"),
                  TextButton(
                    onPressed: () => Get.toNamed("signIn"),
                    child: Text(
                      "Sign In",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
