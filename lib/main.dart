import 'package:e_commerce_admin_app/controllers/auth_controller.dart';
import 'package:e_commerce_admin_app/controllers/home_controller.dart';
import 'package:e_commerce_admin_app/controllers/main_controller.dart';
import 'package:e_commerce_admin_app/controllers/product_controller.dart';
import 'package:e_commerce_admin_app/controllers/sign_in_controller.dart';
import 'package:e_commerce_admin_app/controllers/sign_up_controller.dart';
import 'package:e_commerce_admin_app/controllers/toggle_mode_controller.dart';
import 'package:e_commerce_admin_app/services/auth_api.dart';
import 'package:e_commerce_admin_app/services/local/token_service.dart';
import 'package:e_commerce_admin_app/views/Product_scrren.dart';
import 'package:e_commerce_admin_app/views/home_screen.dart';
import 'package:e_commerce_admin_app/views/main_screen.dart';
import 'package:e_commerce_admin_app/views/sell_screen.dart';
import 'package:e_commerce_admin_app/views/show_terms_privacy_screen.dart';
import 'package:e_commerce_admin_app/views/sign_in_screen.dart';
import 'package:e_commerce_admin_app/views/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(AuthApi());
  Get.put(MainController());
  Get.put(AuthController());
  Get.put(HomeController());
  Get.put(ProductController());
  Get.put(ToggleModeController());
  Get.put(SignInController());
  Get.put(SignUpController());
  Get.put(TokenService());
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
          GetPage(name: "/product", page: () => ProductScrren()),
          GetPage(name: "/sell", page: () => SellScreen()),
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

// ✅ This widget decides whether to show MainScreen or SignInScreen
// ignore: use_key_in_widget_constructors
class RootScreen extends StatelessWidget {
  final TokenService tokenService = Get.find();

  @override
  Widget build(BuildContext context) {
    String? token = tokenService.getToken();
    // You can also show a loading spinner here if checking token from async source
    return token.isNotEmpty ? MainScreen() : SignInScreen();
  }
}
