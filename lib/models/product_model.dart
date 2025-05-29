class ProductResponse {
    ProductResponse({
        required this.success,
        required this.total,
        required this.currentPage,
        required this.totalPages,
        required this.count,
        required this.products,
    });

    final bool? success;
    final int? total;
    final int? currentPage;
    final int? totalPages;
    final int? count;
    final List<Product> products;

    factory ProductResponse.fromJson(Map<String, dynamic> json){ 
        return ProductResponse(
            success: json["success"],
            total: json["total"],
            currentPage: json["currentPage"],
            totalPages: json["totalPages"],
            count: json["count"],
            products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
        );
    }

    factory ProductResponse.empty(){
      return ProductResponse(success: null, total:null, currentPage:null, totalPages:null, count:null, products:[]);
    }

}

class Product {
    Product({
        required this.id,
        required this.name,
        required this.description,
        required this.price,
        required this.categoryId,
        required this.brand,
        required this.stock,
        required this.ratings,
        required this.images,
        required this.createdBy,
        required this.isActive,
        required this.reviews,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String? id;
    final String? name;
    final String? description;
    final double? price;
    final String? categoryId;
    final String? brand;
    final int? stock;
    final int? ratings;
    final List<Image> images;
    final String? createdBy;
    final bool? isActive;
    final List<dynamic> reviews;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    factory Product.fromJson(Map<String, dynamic> json){ 
        return Product(
            id: json["_id"],
            name: json["name"],
            description: json["description"],
            price: json["price"],
            categoryId: json["categoryId"],
            brand: json["brand"],
            stock: json["stock"],
            ratings: json["ratings"],
            images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
            createdBy: json["createdBy"],
            isActive: json["isActive"],
            reviews: json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]!.map((x) => x)),
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
        );
    }

}

class Image {
    Image({
        required this.url,
        required this.id,
    });

    final String? url;
    final String? id;

    factory Image.fromJson(Map<String, dynamic> json){ 
        return Image(
            url: json["url"],
            id: json["_id"],
        );
    }

}
