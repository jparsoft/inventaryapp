class ProductModel {
  String name;
  String price;

  String category;

  ProductModel({
    required this.name,
    required this.price,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'category': category,
    };
  }

  // copyWith
  ProductModel copyWith({
    String? name,
    String? price,
    String? category,
  }) {
    return ProductModel(
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
    );
  }

  // fromJson

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'] as String,
      price: json['price'] as String,
      category: json['category'] as String,
    );
  }
}

class ProductResponse extends ProductModel {
  String id;
  ProductResponse(
      {required super.name,
      required super.price,
      required super.category,
      required this.id});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as String,
      category: json['category'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'category': category,
    };
  }
}
