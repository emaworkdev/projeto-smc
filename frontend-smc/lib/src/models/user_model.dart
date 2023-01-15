// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class UserModel {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic password;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt() ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonDados = <String, dynamic>{};

    jsonDados['id'] = id;
    jsonDados['name'] = name;
    jsonDados['email'] = email;
    jsonDados['password'] = password;

    return jsonDados;
  }

  String objetoEncodeJson(UserModel objeto) {
    final jsonDados = objeto.toJson;
    return json.encode(jsonDados);
  }

  static List<UserModel> fromJsonList(List list) {
    return list.map<UserModel>((item) => UserModel.fromMap(item)).toList();
  }
}
