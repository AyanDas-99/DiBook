// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String name;
  final String email;
  final String password;
  final String token;
  final String id;
  String address;

  User(
      {required this.name,
      required this.email,
      required this.password,
      required this.token,
      required this.id,
      required this.address});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'token': token,
      'id': id,
      'address': address,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      email: map['email'] as String,
      token: map['token'] as String,
      password: map['password'] as String,
      id: map['id'] as String,
      address: map['address'] as String,
    );
  }

  User copyWithAddress(String address) {
    this.address = address;
    return this;
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  operator ==(covariant User other) =>
      name == other.name && email == other.email;

  @override
  int get hashCode => Object.hashAll([
        name,
        email,
        password,
        id,
      ]);
}
