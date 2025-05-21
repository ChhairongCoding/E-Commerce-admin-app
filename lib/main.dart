import 'package:e_commerce_admin_app/controllers/auth_controller.dart';
import 'package:e_commerce_admin_app/controllers/sign_in_controller.dart';
import 'package:e_commerce_admin_app/controllers/toggle_mode_controller.dart';
import 'package:e_commerce_admin_app/views/home_screen.dart';
import 'package:e_commerce_admin_app/views/show_terms_privacy_screen.dart';
import 'package:e_commerce_admin_app/views/sign_in_screen.dart';
import 'package:e_commerce_admin_app/views/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';

void main() {
  Get.put(AuthController());
  Get.put(ToggleModeController());
  Get.put( SignInController ());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      defaultTransition: Transition.fadeIn,
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => SignInScreen()),
        GetPage(name: "/signUp", page: () => SignUpScreen()),
        GetPage(name: "/home", page: () => HomeScreen()),
        GetPage(
          name: "/showTermsAndPrivacy",
          page: () => ShowTermsPrivacyScreen(),
          transition: Transition.downToUp,
          transitionDuration: Duration(milliseconds: 300),
        ),
      ],
    );
  }
}
