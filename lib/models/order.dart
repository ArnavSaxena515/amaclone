import 'package:amaclone/models/product.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final int orderedAt;
  final int? status;
  final int totalPrice;

  const Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.totalPrice,
     this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products,
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'orderedAt': orderedAt,
      'status': status,
      'totalPrice': totalPrice
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] as String,
      products: List<Product>.from(
          map['products']?.map((x) => Product.fromJson(x['product']))),
      quantity: List<int>.from(map['products']?.map((x) => x['quantity'])),
      address: map['address'] as String,
      userId: map['userId'] as String,
      orderedAt: int.parse(map['orderedAt']) ,
      status: map['status']!=null? map['status'] as int : null,
      totalPrice: map['totalPrice'],
    );
  }

  factory Order.fromJson(Map<String, dynamic> json) {


    return Order(
      id: json["_id"],
      products: List<Product>.from(json['products']?.map((x) => Product.fromJson(x['product']))),
      quantity: List<int>.from(json['products']?.map((x) => x['quantity'])),
      address: json["address"],
      userId: json["userId"],
      orderedAt: json["orderedAt"],
      status: json["status"]??0,
      totalPrice: (json['totalPrice'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "products": products,
      "quantity": quantity,
      "address": address,
      "userId": userId,
      "orderedAt": orderedAt,
      "status": status,
      "totalPrice": totalPrice
    };
  }
//
}
