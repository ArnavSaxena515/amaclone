// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
    name: json['name'] as String,
    description: json['description'] as String,
    category: json['category'] as String,
    quantity: (json['quantity'] as num).toDouble(),
    price: (json['price'] as num).toDouble(),
    sellerId: json['sellerId'] as String,
    images:
    (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    id: json['_id'] as String?,
    rating: json['averageRating']!=null? (json['averageRating'] as num).toDouble() : null
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'category': instance.category,
  'quantity': instance.quantity,
  'price': instance.price,
  'id': instance.id,
  'sellerId': instance.sellerId,
  'images': instance.images,
};
