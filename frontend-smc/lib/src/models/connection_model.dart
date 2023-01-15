// ignore_for_file: avoid_renaming_method_parameters

import 'dart:convert';

class ConnectionModel {
  dynamic id;
  dynamic status;

  ConnectionModel({
    this.id,
    this.status,
  });

  ConnectionModel copyWith({
    dynamic id,
    dynamic status,
  }) {
    return ConnectionModel(
      id: id ?? this.id,
      status: status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
    };
  }

  factory ConnectionModel.fromMap(Map<String, dynamic> map) {
    return ConnectionModel(
      id: map['id'],
      status: map['status'],
    );
  }

  @override
  String toString() => 'ConnectionModel(id: $id, status: $status)';

  String toJson() => json.encode(toMap());

  factory ConnectionModel.fromJson(String source) =>
      ConnectionModel.fromMap(json.decode(source));

  static List<ConnectionModel> fromJsonList(List list) {
    return list
        .map<ConnectionModel>((item) => ConnectionModel.fromMap(item))
        .toList();
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ConnectionModel && o.id == id && o.status == status;
  }

  @override
  int get hashCode => id.hashCode ^ status.hashCode;
}
