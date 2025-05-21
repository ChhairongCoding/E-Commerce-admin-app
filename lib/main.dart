import 'package:e_commerce_admin_app/controllers/auth_controller.dart';
import 'package:e_commerce_admin_app/controllers/main_controller.dart';
import 'package:e_commerce_admin_app/controllers/sign_in_controller.dart';
import 'package:e_commerce_admin_app/controllers/toggle_mode_controller.dart';
import 'package:e_commerce_admin_app/views/home_screen.dart';
import 'package:e_commerce_admin_app/views/main_screen.dart';
import 'package:e_commerce_admin_app/views/show_terms_privacy_screen.dart';
import 'package:e_commerce_admin_app/views/sign_in_screen.dart';
import 'package:e_commerce_admin_app/views/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(MainController());
  Get.put(AuthController());
  Get.put(ToggleModeController());
  Get.put(SignInController());
  Get.put(ToggleModeController());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ToggleModeController toggleModeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: 'Flutter Demo',
        theme: toggleModeController.currentTheme,
        defaultTransition: Transition.fadeIn,
        initialRoute: "/",
        getPages: [
          GetPage(name: "/", page: () => MainScreen()),
          GetPage(name: "/home", page: () => HomeScreen()),
          GetPage(name: "/signIn", page: () => SignInScreen()),
          GetPage(name: "/signUp", page: () => SignUpScreen()),
          GetPage(
            name: "/showTermsAndPrivacy",
            page: () => ShowTermsPrivacyScreen(),
            transition: Transition.downToUp,
            transitionDuration: Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
