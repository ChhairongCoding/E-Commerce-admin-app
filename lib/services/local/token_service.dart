import 'package:get_storage/get_storage.dart';

class TokenService {
  final box = GetStorage();
  final key = "token";
  void setToken(String token) {
    box.write(key, token);
  }

  String getToken() {
    return box.read(key) ?? "";
  }

  void clearToken() {
    box.remove(key);
  }
}
