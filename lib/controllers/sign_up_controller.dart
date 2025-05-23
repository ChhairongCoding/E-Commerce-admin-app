import 'package:e_commerce_admin_app/services/auth_api.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  RxBool isChecked = false.obs;
  final AuthApi auth = Get.find();
  Future<void> signUp(String fullname, String email, String password) async {
    await auth.signUp(fullname, email, password);
  }
}
