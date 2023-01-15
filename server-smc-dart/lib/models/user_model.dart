// ignore_for_file: avoid_renaming_method_parameters, non_constant_identifier_names

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

  UserModel copyWith({
    dynamic id,
    dynamic name,
    dynamic email,
    dynamic password,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name,
      email: email,
      password: password,
    );
  }

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
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }

  @override
  String toString() =>
      'UserModel(id: $id, ame: $name, email: $email, password: $password)';

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  static List<UserModel> fromJsonList(List list) {
    return list.map<UserModel>((item) => UserModel.fromMap(item)).toList();
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserModel &&
        o.id == id &&
        o.name == name &&
        o.email == email &&
        o.password == password;
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ email.hashCode ^ password.hashCode;
}
