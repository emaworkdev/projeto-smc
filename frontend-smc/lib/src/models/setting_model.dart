// ignore_for_file: non_constant_identifier_keys

import 'dart:convert';

class SettingModel {
  dynamic id;
  dynamic description;
  dynamic key;
  dynamic value;
  dynamic content;

  SettingModel({
    this.id,
    this.description,
    this.key,
    this.value,
    this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'key': key,
      'value': value,
      'content': content,
    };
  }

  factory SettingModel.fromMap(Map<String, dynamic> map) {
    return SettingModel(
      id: map['id']?.toInt() ?? '',
      description: map['description'] ?? '',
      key: map['key'] ?? '',
      value: map['value'] ?? false,
      content: map['content'] ?? '',
    );
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonDados = <String, dynamic>{};

    jsonDados['id'] = id;
    jsonDados['description'] = description;
    jsonDados['key'] = key;
    jsonDados['value'] = value;
    jsonDados['content'] = content;

    return jsonDados;
  }

  String objetoEncodeJson(SettingModel objeto) {
    final jsonDados = objeto.toJson;
    return json.encode(jsonDados);
  }

  static List<SettingModel> fromJsonList(List list) {
    return list
        .map<SettingModel>((item) => SettingModel.fromMap(item))
        .toList();
  }
}
