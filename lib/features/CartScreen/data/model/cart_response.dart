class CartProduct {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;

  CartProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });


  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'quantity': quantity,
    'imageUrl': imageUrl,
  };

  CartProduct copyWith({
    int? id,
    String? name,
    double? price,
    int? quantity,
    String? imageUrl,
  }) {
    return CartProduct(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }


  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
    id: json['id'],
    name: json['name'],
    price: (json['price'] as num).toDouble(),
    quantity: json['quantity'],
    imageUrl: json['imageUrl'],
  );
}
