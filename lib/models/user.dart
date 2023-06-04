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

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.address,
    required this.token,
    required this.type,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Connect the generated [_$UserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
