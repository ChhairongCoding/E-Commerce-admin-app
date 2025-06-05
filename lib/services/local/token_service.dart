import 'dart:convert';
import 'dart:developer';
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

  /// Decodes the JWT and returns the payload as a Map.
  Map<String, dynamic>? decodeToken() {
    final token = getToken();
    if (token.isEmpty) return null;

    final parts = token.split('.');
    if (parts.length != 3) return null;

    try {
      final payload = base64Url.normalize(parts[1]);
      final decoded = utf8.decode(base64Url.decode(payload));
      return json.decode(decoded) as Map<String, dynamic>;
    } catch (e) {
      log("JWT Decode Error: $e");
      return null;
    }
  }
}
