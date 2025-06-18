final baseUrl = "https://e-commerce-api-24yv.onrender.com/api";

Map<String, String> headers(String token) {
  return {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
}
