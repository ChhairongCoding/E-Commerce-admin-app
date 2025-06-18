import 'dart:convert';
import 'dart:developer';
import 'package:e_commerce_admin_app/core/constand.dart';
import 'package:e_commerce_admin_app/models/category_model.dart';
import 'package:e_commerce_admin_app/services/local/token_service.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  Future<List<Category>> getCategory() async {
    TokenService tokenService = TokenService();
    try {
      final token = tokenService.getToken();
      var url = Uri.parse("$baseUrl/categories");
      var res = await http.get(
        url,
        headers: {
          "x-api-key": "my_super_secret_key",
          "Authorization": "Bearer $token",
        },
      );

      if (res.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(res.body);
        return jsonList
            .map<Category>((json) => Category.fromJson(json))
            .toList();
      } else {
        log("Failed to load categories. Status: ${res.statusCode}");
        return [];
      }
    } catch (e) {
      log("Error fetching categories: $e");
      return [];
    }
  }
}
