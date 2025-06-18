import 'dart:convert';
import 'dart:developer' as developer;
import 'package:e_commerce_admin_app/core/constand.dart';
import 'package:e_commerce_admin_app/models/brand_model.dart';
import 'package:e_commerce_admin_app/services/local/token_service.dart';
import 'package:http/http.dart' as http;

class BrandService {
  Future<BrandResponse> getBrands() async {
    try {
      final token = TokenService().getToken();
      final url = Uri.parse("$baseUrl/brands");
      final res = await http.get(url, headers: headers(token));
      developer.log("BrandRes: ${res.body}");
      if (res.statusCode == 200) {
        return BrandResponse.fromJson(
          jsonDecode(res.body) as Map<String, dynamic>,
        );
      } else {
        return BrandResponse.empty();
      }
    } catch (e) {
      developer.log("Error getbrand: $e", name: "BrandService.getBrands");
      return BrandResponse.empty();
    }
  }
}
