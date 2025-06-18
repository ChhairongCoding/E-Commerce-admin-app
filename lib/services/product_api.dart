import 'dart:convert';
import 'dart:developer';
import 'package:e_commerce_admin_app/core/constand.dart';
import 'package:e_commerce_admin_app/models/product_model.dart';
import 'package:e_commerce_admin_app/services/local/token_service.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  TokenService tokenService = TokenService();

  Future<ProductResponse> fetchAllProducts() async {
    try {
      final token = tokenService.getToken();

      var url = Uri.parse("$baseUrl/products/my-products");
      var res = await http.get(
        url,
        headers: {
          "x-api-key": "my_super_secret_key",
          "Authorization": "Bearer $token",
        },
      );

      if (res.statusCode == 200) {
        return ProductResponse.fromJson(jsonDecode(res.body));
      } else {
        throw "Fetching Products error: ${res.body}";
      }
    } catch (e) {
      log("Error: $e");
      return ProductResponse.empty();
    }
  }
}
