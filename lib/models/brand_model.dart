class BrandResponse {
  BrandResponse({this.success, required this.data});

  final bool? success;
  final List<Brand> data;

  factory BrandResponse.fromJson(Map<String, dynamic> json) {
    return BrandResponse(
      success: json["success"],
      data: json["data"] == null
          ? []
          : List<Brand>.from(json["data"]!.map((x) => Brand.fromJson(x))),
    );
  }

  @override
  String toString() {
    return "$success, $data, ";
  }

  factory BrandResponse.empty() {
    return BrandResponse(data: []);
  }
}

class Brand {
  Brand({
    required this.id,
    required this.name,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.totalProducts,
  });

  final String? id;
  final String? name;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? totalProducts;

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json["_id"],
      name: json["name"],
      isActive: json["isActive"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      totalProducts: json["totalProducts"],
    );
  }
  factory Brand.empty() {
    return Brand(
      id: '',
      name: '',
      isActive: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      totalProducts: 0,
    );
  }

  @override
  String toString() {
    return "$id, $name, $isActive, $createdAt, $updatedAt, $totalProducts, ";
  }
}
