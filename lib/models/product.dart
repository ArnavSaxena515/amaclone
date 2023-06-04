import 'dart:convert';

class Product {
  final String name, description, category;
  final double quantity, price;
  final String? id;
  final String sellerId;
  final List<String> imageUrls;

  //todo add rating
  Product({
    required this.name,
    required this.description,
    required this.category,
    required this.quantity,
    required this.price,
    required this.sellerId,
    required this.imageUrls,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "category": category,
      "quantity": quantity,
      "price": price,
      "id": id,
      "sellerId": sellerId,
      "imageUrls": jsonEncode(imageUrls),
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json["name"],
      description: json["description"],
      category: json["category"],
      quantity: double.parse(json["quantity"]),
      price: json["price"],
      id: json["id"],
      sellerId: json["sellerId"],
      imageUrls: json["imageUrls"],
          //List.of(json["imageUrls"]).map((i) => json["imageUrls"]).toList(),
    );
  }
//

//
}
