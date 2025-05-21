import 'package:e_commerce_admin_app/services/auth_api.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  
  final AuthApi aut = AuthApi();
  Future<void> login(String email , String password)async{
    aut.login(email, password);
  }
}