// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class WhatsappModel {
  dynamic id;
  dynamic session;
  dynamic qrcode;
  dynamic status;
  dynamic battery;
  dynamic plugged;
  DateTime? updatedAt;
  dynamic name;
  dynamic isDefault;
  dynamic retries;
  dynamic number;

  WhatsappModel({
    this.id,
    this.session,
    this.qrcode,
    this.status,
    this.battery,
    this.plugged,
    this.updatedAt,
    this.name,
    this.isDefault,
    this.retries,
    this.number,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'session': session,
      'qrcode': qrcode,
      'status': status,
      'battery': battery,
      'plugged': plugged,
      'updatedAt': updatedAt,
      'name': name,
      'isDefault': isDefault,
      'retries': retries,
      'number': number,
    };
  }

  factory WhatsappModel.fromMap(Map<String, dynamic> map) {
    return WhatsappModel(
      id: map['id'],
      session: map['session'],
      qrcode: map['qrcode'],
      status: map['status'],
      battery: map['battery'],
      plugged: map['plugged'],
      updatedAt:
          map['updatedAt'] != null ? DateTime.tryParse(map['updatedAt']) : null,
      name: map['name'],
      isDefault: map['isDefault'],
      retries: map['retries'],
      number: map['number'],
    );
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonDados = <String, dynamic>{};

    jsonDados['id'] = id;
    jsonDados['session'] = session;
    jsonDados['qrcode'] = qrcode;
    jsonDados['status'] = status;
    jsonDados['battery'] = battery;
    jsonDados['plugged'] = plugged;
    jsonDados['updatedAt'] = updatedAt;
    jsonDados['name'] = name;
    jsonDados['isDefault'] = isDefault;
    jsonDados['retries'] = retries;
    jsonDados['number'] = number;

    return jsonDados;
  }

  String objetoEncodeJson(WhatsappModel objeto) {
    final jsonDados = objeto.toJson;
    return json.encode(jsonDados);
  }

  static List<WhatsappModel> fromJsonList(List list) {
    return list
        .map<WhatsappModel>((item) => WhatsappModel.fromMap(item))
        .toList();
  }
}
