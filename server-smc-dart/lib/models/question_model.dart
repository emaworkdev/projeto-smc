// ignore_for_file: avoid_renaming_method_parameters, non_constant_identifier_names

import 'dart:convert';

class QuestionModel {
  dynamic id;
  dynamic name;

  QuestionModel({
    this.id,
    this.name,
  });

  QuestionModel copyWith({
    dynamic id,
    dynamic tenantId,
    dynamic name,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      name: name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'],
      name: map['name'],
    );
  }

  @override
  String toString() => 'QuestionModel(id: $id, ame: $name)';

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(json.decode(source));

  static List<QuestionModel> fromJsonList(List list) {
    return list
        .map<QuestionModel>((item) => QuestionModel.fromMap(item))
        .toList();
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is QuestionModel && o.id == id && o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
