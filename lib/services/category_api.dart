import 'dart:convert';
import 'dart:developer' as developer;
import 'package:e_commerce_admin_app/core/constand.dart';
import 'package:e_commerce_admin_app/models/category_model.dart';
import 'package:e_commerce_admin_app/services/local/token_service.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  Future<CategoryResponse> getCategories() async {
    try {
      final token = TokenService().getToken();
      var url = Uri.parse("$baseUrl/categories");
      var res = await http.get(url, headers: headers(token));
      developer.log("BrandRes: ${res.body}");
      if (res.statusCode == 200) {
        return CategoryResponse.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>,
        );
      } else {
        developer.log("Failed to load categories. Status: ${res.statusCode}");
        return CategoryResponse.empty();
      }
    } catch (e) {
      return CategoryResponse.empty();
    }
  }
}
