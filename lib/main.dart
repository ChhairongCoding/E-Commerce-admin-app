import 'package:e_commerce_admin_app/controllers/category_controller.dart';
import 'package:e_commerce_admin_app/controllers/home_controller.dart';
import 'package:e_commerce_admin_app/controllers/main_controller.dart';
import 'package:e_commerce_admin_app/controllers/product_controller.dart';
import 'package:e_commerce_admin_app/controllers/sign_in_controller.dart';
import 'package:e_commerce_admin_app/controllers/sign_up_controller.dart';
import 'package:e_commerce_admin_app/controllers/toggle_mode_controller.dart';
import 'package:e_commerce_admin_app/controllers/update_add_controller.dart';
import 'package:e_commerce_admin_app/services/auth_api.dart';
import 'package:e_commerce_admin_app/services/local/token_service.dart';
import 'package:e_commerce_admin_app/views/product-views/product_screen.dart';
import 'package:e_commerce_admin_app/views/home_screen.dart';
import 'package:e_commerce_admin_app/views/main_screen.dart';
import 'package:e_commerce_admin_app/views/sell_screen.dart';
import 'package:e_commerce_admin_app/views/show_terms_privacy_screen.dart';
import 'package:e_commerce_admin_app/views/sign_in_screen.dart';
import 'package:e_commerce_admin_app/views/sign_up_screen.dart';
import 'package:e_commerce_admin_app/views/update_add_screen.dart';
import 'package:e_commerce_admin_app/views/product-views/add_product_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(AuthApi());
  Get.put(MainController());
  Get.put(HomeController());
  Get.put(ProductController());
  Get.put(ToggleModeController());
  Get.put(SignInController());
  Get.put(SignUpController());
  Get.put(TokenService());
  Get.put(UpdateAddController());
  Get.put(CategoryController());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ToggleModeController toggleModeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: 'E-commerce Admin App',
        theme: toggleModeController.currentTheme,
        initialRoute: "/",
        getPages: [
          GetPage(name: "/", page: () => RootScreen()),
          GetPage(name: "/home", page: () => HomeScreen()),
          GetPage(name: "/product", page: () => ProductScreen()),
          GetPage(name: "/sell", page: () => SellScreen()),
          GetPage(name: "/signIn", page: () => SignInScreen()),
          GetPage(name: "/signUp", page: () => SignUpScreen()),
          GetPage(name: "/updateAdd", page: () => UpdateAddScreen()),
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
