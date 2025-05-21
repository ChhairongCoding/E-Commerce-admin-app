import 'package:e_commerce_admin_app/controllers/sign_in_controller.dart';
import 'package:e_commerce_admin_app/widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final SignInController signInController = Get.find();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return Center(
                  child: Container(
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
                    child: buildMobile(
                      signInController: signInController,
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                  ),
                );
              }
              return buildMobile(
                signInController: signInController,
                emailController: emailController,
                passwordController: passwordController,
              );
            },
          ),
        ),
      ),
    );
  }
}

class buildMobile extends StatelessWidget {
  const buildMobile({
    super.key,
    required this.signInController,
    required this.emailController,
    required this.passwordController,
  });

  final SignInController signInController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome Back!",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 38,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Please sign In for continue to home screen.",
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
        SizedBox(height: 40),
        Form(
          child: Column(
            children: [
              SizedBox(
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email Address", style: TextStyle(fontSize: 14)),
                    CustomTextfieldWidget(
                      hintText: "Enter Email",
                      controller: emailController,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Password", style: TextStyle(fontSize: 14)),
                    CustomTextfieldWidget(
                      hintText: "Enter Password",
                      controller: passwordController,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text("Forgot Password?")],
              ),
              SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Color(0xff012B43),
                  minimumSize: Size(double.infinity, 60),
                ),
                child: Text("Sign In", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  String email = emailController.text;
                  String password = passwordController.text;
                  signInController.login(email, password);
                  email = '';
                  password = '';
                },
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Or", style: TextStyle(fontSize: 15))],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    icon: Image.asset(
                      "assets/images/icons/google.png",
                      height: 45,
                      width: 45,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/images/icons/phone.png",
                      height: 50,
                      width: 50,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have any accout!"),
                  TextButton(
                    child: Text("Sign up"),
                    onPressed: () {
                      Get.toNamed("/signUp");
                    },
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
