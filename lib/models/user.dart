import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String name;
  final String password;
  final String email;
  final String address;
  final String type;
  final String token;
  List<dynamic> cart;

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.address,
    required this.token,
    required this.type,
    this.cart=const[],
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Connect the generated [_$UserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? name,
    String? password,
    String? email,
    String? address,
    String? type,
    String? token,
    List<dynamic>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart,
    );
  }
}
// user.g.dart
// GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'user.dart';
//
// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************
//
// User _$UserFromJson(Map<String, dynamic> json) => User(
//   id: json['_id'] as String,
//   name: json['name'] as String,
//   password: json['password'] as String,
//   email: json['email'] as String,
//   address: json['address'] as String,
//   token: json['token'] as String,
//   type: json['type'] as String,
// );
//
// Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
//   '_id': instance.id,
//   'name': instance.name,
//   'password': instance.password,
//   'email': instance.email,
//   'address': instance.address,
//   'type': instance.type,
//   'token': instance.token,
// };
