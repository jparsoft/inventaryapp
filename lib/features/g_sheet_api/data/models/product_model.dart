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
    String? quantity,
    String? description,
    String? image,
    String? category,
    String? createdAt,
    String? id,
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
