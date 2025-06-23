
import 'dart:io';

import 'package:e_commerce_admin_app/binding/init_binding.dart';
import 'package:e_commerce_admin_app/controllers/toggle_mode_controller.dart';
import 'package:e_commerce_admin_app/services/local/token_service.dart';
import 'package:e_commerce_admin_app/views/product-views/product_screen.dart';
import 'package:e_commerce_admin_app/views/home_screen.dart';
import 'package:e_commerce_admin_app/views/main_screen.dart';
import 'package:e_commerce_admin_app/views/sell_screen.dart';
import 'package:e_commerce_admin_app/views/show_terms_privacy_screen.dart';
import 'package:e_commerce_admin_app/views/sign_in_screen.dart';
import 'package:e_commerce_admin_app/views/sign_up_screen.dart';
import 'package:e_commerce_admin_app/views/product-views/add_product_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        initialBinding: InitBinding(),
        title: 'E-commerce Admin App',
        theme: Get.put(ToggleModeController()).currentTheme,
        initialRoute: "/",
        getPages: [
          GetPage(name: "/", page: () => RootScreen()),
          GetPage(name: "/home", page: () => HomeScreen()),
          GetPage(name: "/product", page: () => ProductScreen()),
          GetPage(name: "/sell", page: () => SellScreen()),
          GetPage(name: "/signIn", page: () => SignInScreen()),
          GetPage(name: "/signUp", page: () => SignUpScreen()),
          GetPage(name: "/form", page: () => AddProductFormScreen()),
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

class RootScreen extends StatelessWidget {
  final TokenService tokenService = Get.find();
  RootScreen({super.key});
  @override
  Widget build(BuildContext context) {
    String? token = tokenService.getToken();
    return token.isNotEmpty ? MainScreen() : SignInScreen();
  }
}