// ignore_for_file: non_constant_identifier_keys

import 'dart:convert';

class QuestionModel {
  dynamic id;
  dynamic name;

  QuestionModel({
    this.id,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id']?.toInt() ?? '',
      name: map['name'] ?? '',
    );
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonDados = <String, dynamic>{};

    jsonDados['id'] = id;
    jsonDados['name'] = name;

    return jsonDados;
  }

  String objetoEncodeJson(QuestionModel objeto) {
    final jsonDados = objeto.toJson;
    return json.encode(jsonDados);
  }

  static List<QuestionModel> fromJsonList(List list) {
    return list
        .map<QuestionModel>((item) => QuestionModel.fromMap(item))
        .toList();
  }
}
