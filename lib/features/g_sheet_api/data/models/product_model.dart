class ProductModel {
  String name;
  String price;
  String quantity;
  String description;
  String image;
  String category;
  String createdAt;
  String id;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.image,
    required this.category,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'description': description,
      'image': image,
      'category': category,
      'createdAt': createdAt,
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
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      image: image ?? this.image,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
