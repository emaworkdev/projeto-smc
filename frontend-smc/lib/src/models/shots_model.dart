// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class ShotsModel {
  dynamic id;
  dynamic name;
  dynamic namecli;
  dynamic datestart;
  dynamic datefinalize;
  dynamic start;
  dynamic finished;
  dynamic control;
  dynamic alvo;
  dynamic client;
  dynamic createdAt;

  ShotsModel({
    this.id,
    this.name,
    this.namecli,
    this.datestart,
    this.datefinalize,
    this.start,
    this.finished,
    this.control,
    this.alvo,
    this.client,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'namecli': namecli,
      'datestart': datestart,
      'datefinalize': datefinalize,
      'start': start,
      'finished': finished,
      'control': control,
      'alvo': alvo,
      'client': client,
      'createdAt': createdAt,
    };
  }

  factory ShotsModel.fromMap(Map<String, dynamic> map) {
    return ShotsModel(
      id: map['id'],
      name: map['name'],
      namecli: map['namecli'],
      datestart: map['datestart'],
      datefinalize: map['datefinalize'],
      start: map['start'],
      finished: map['finished'],
      control: map['control'],
      alvo: map['alvo'],
      client: map['client'],
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonDados = <String, dynamic>{};

    jsonDados['id'] = id;
    jsonDados['name'] = name;
    jsonDados['namecli'] = namecli;
    jsonDados['datestart'] = datestart;
    jsonDados['datefinalize'] = datefinalize;
    jsonDados['start'] = start;
    jsonDados['finished'] = finished;
    jsonDados['control'] = control;
    jsonDados['alvo'] = alvo;
    jsonDados['client'] = client;
    jsonDados['createdAt'] = createdAt;

    return jsonDados;
  }

  String objetoEncodeJson(ShotsModel objeto) {
    final jsonDados = objeto.toJson;
    return json.encode(jsonDados);
  }

  static List<ShotsModel> fromJsonList(List list) {
    return list.map<ShotsModel>((item) => ShotsModel.fromMap(item)).toList();
  }
}
