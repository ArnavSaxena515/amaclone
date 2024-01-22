import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable()
class Product {
  final String name, description, category;
  final double quantity, price;
  final String? id;
  final String sellerId;
  final List<String> images;
  double? rating;

  Product({
    required this.name,
    required this.description,
    required this.category,
    required this.quantity,
    required this.price,
    required this.sellerId,
    required this.images,
    this.rating,
    this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  /// Connect the generated [_$ProductToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  // Map<String, dynamic> toJson() {
  //   return {
  //     "name": name,
  //     "description": description,
  //     "category": category,
  //     "quantity": quantity,
  //     "price": price,
  //     "_id": id,
  //     "sellerId": sellerId,
  //     "images": jsonEncode(images),
  //   };
  // }
  //
  // factory Product.fromJson(Map<String, dynamic> json) {
  //   print("JSONN");
  //   print(json);
  //   return Product(
  //     name: json["name"],
  //     description: json["description"],
  //     category: json["category"],
  //     quantity: double.parse(json["quantity"]),
  //     price: json["price"],
  //     id: json["_id"],
  //     sellerId: json["sellerId"],
  //     images: json["images"],
  //         //List.of(json["imageUrls"]).map((i) => json["imageUrls"]).toList(),
  //   );
  // }

}


// product .g dart

// GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'product.dart';
//
// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************
//
// Product _$ProductFromJson(Map<String, dynamic> json) => Product(
//     name: json['name'] as String,
//     description: json['description'] as String,
//     category: json['category'] as String,
//     quantity: (json['quantity'] as num).toDouble(),
//     price: (json['price'] as num).toDouble(),
//     sellerId: json['sellerId'] as String,
//     images:
//     (json['images'] as List<dynamic>).map((e) => e as String).toList(),
//     id: json['_id'] as String?,
//     rating: json['averageRating']!=null? (json['averageRating'] as num).toDouble() : null
// );
//
// Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
//   'name': instance.name,
//   'description': instance.description,
//   'category': instance.category,
//   'quantity': instance.quantity,
//   'price': instance.price,
//   'id': instance.id,
//   'sellerId': instance.sellerId,
//   'images': instance.images,
// };
