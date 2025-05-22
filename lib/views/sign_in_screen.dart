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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  child: buildMobile(
                    signInController: signInController,
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
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
    final size = MediaQuery.of(context).size;
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
                        border: Border.all(color: Colors.black),
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
                        border: Border.all(color: Colors.black),
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
            SizedBox(height: 30),

            Row(
              spacing: 10,
              children: [
                Expanded(child: Divider(thickness: 1,)),
                Text( "Or Continue With Email", style: TextStyle(fontSize: 15)),
                Expanded(child: Divider(thickness: 1,)),

              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Form(
          child: Column(
            children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email Address", style: TextStyle(fontSize: 14)),
                    SizedBox(height: 10),
                    CustomTextfieldWidget(
                      hintText: "Enter Email",
                      controller: emailController,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Password", style: TextStyle(fontSize: 14)),
                    SizedBox(height: 10),
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
                onPressed: () {
                  String email = emailController.text;
                  String password = passwordController.text;
                  signInController.login(email, password);
                  emailController.clear();
                  passwordController.clear();
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have any account!"),
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
