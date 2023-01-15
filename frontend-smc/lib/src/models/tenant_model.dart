// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class TenantModel {
  dynamic id;
  dynamic ownerId;
  dynamic name;
  dynamic status;
  dynamic urlApi01;
  dynamic urlApi02;
  dynamic urlWebhook01;
  dynamic urlWebhook02;
  dynamic sessionQtde;

  TenantModel(
      {this.id,
      this.ownerId,
      this.name,
      this.status,
      this.urlApi01,
      this.urlApi02,
      this.urlWebhook01,
      this.urlWebhook02,
      this.sessionQtde});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerId': ownerId,
      'name': name,
      'status': status,
      'urlApi01': urlApi01,
      'urlApi02': urlApi02,
      'urlWebhook01': urlWebhook01,
      'urlWebhook02': urlWebhook02,
      'sessionQtde': sessionQtde,
    };
  }

  factory TenantModel.fromMap(Map<String, dynamic> map) {
    return TenantModel(
      id: map['id'],
      ownerId: map['ownerId'],
      name: map['name'],
      status: map['status'],
      urlApi01: map['urlApi01'],
      urlApi02: map['urlApi02'],
      urlWebhook01: map['urlWebhook01'],
      urlWebhook02: map['urlWebhook02'],
      sessionQtde: map['sessionQtde'],
    );
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonDados = <String, dynamic>{};

    jsonDados['id'] = id;
    jsonDados['ownerId'] = ownerId;
    jsonDados['name'] = name;
    jsonDados['status'] = status;
    jsonDados['urlApi01'] = urlApi01;
    jsonDados['urlApi02'] = urlApi02;
    jsonDados['urlWebhook01'] = urlWebhook01;
    jsonDados['urlWebhook02'] = urlWebhook02;
    jsonDados['sessionQtde'] = sessionQtde;

    return jsonDados;
  }

  String objetoEncodeJson(TenantModel objeto) {
    final jsonDados = objeto.toJson;
    return json.encode(jsonDados);
  }

  static List<TenantModel> fromJsonList(List list) {
    return list.map<TenantModel>((item) => TenantModel.fromMap(item)).toList();
  }
}
