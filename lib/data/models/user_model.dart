import 'package:firebase_auth/firebase_auth.dart' as firebase_user;

import '../../domain/entities/user.dart';

class UserModel {
  final String? id;
  final String? email;
  final String? name;
  final String? password;
  final String? phoneNumber;

  UserModel({
    this.id,
    this.email,
    this.name,
    this.password,
    this.phoneNumber,
  });

  factory UserModel.fromEntity(User user) {
    return UserModel(
      email: user.email,
      name: user.name,
      password: user.password,
      phoneNumber: user.phoneNumber,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic>? data) => UserModel(
        email: data?['email'],
        name: data?['name'],
        phoneNumber: data?['phone_number'],
        password: data?['password'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'phone_number': phoneNumber,
        'password': password,
      };
  User toEntity() {
    return User(
      id: id!,
      email: email!,
      name: name!,
      password: password!,
      phoneNumber: phoneNumber!,
    );
  }

  User fromAuth(firebase_user.User user) {
    return User(
      id: user.uid,
      email: user.email,
      name: user.displayName,
    );
  }
}
