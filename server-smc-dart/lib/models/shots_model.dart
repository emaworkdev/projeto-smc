// ignore_for_file: avoid_renaming_method_parameters

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

  ShotsModel copyWith({
    dynamic id,
    dynamic name,
    dynamic namecli,
    dynamic datestart,
    dynamic datefinalize,
    dynamic start,
    dynamic finished,
    dynamic control,
    dynamic alvo,
    DateTime? client,
    dynamic createdAt,
  }) {
    return ShotsModel(
      id: id ?? this.id,
      name: name,
      namecli: namecli,
      datestart: datestart,
      datefinalize: datefinalize,
      start: start,
      finished: finished,
      control: control,
      alvo: alvo,
      client: client,
      createdAt: createdAt,
    );
  }

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

  @override
  String toString() =>
      'ShotsModel(id: $id, name: $name, namecli: $namecli, datestart: $datestart, datefinalize: $datefinalize, start: $start, finished: $finished, control: $control, alvo: $alvo, client: $client, createdAt: $createdAt)';

  String toJson() => json.encode(toMap());

  factory ShotsModel.fromJson(String source) =>
      ShotsModel.fromMap(json.decode(source));

  static List<ShotsModel> fromJsonList(List list) {
    return list.map<ShotsModel>((item) => ShotsModel.fromMap(item)).toList();
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ShotsModel &&
        o.id == id &&
        o.name == name &&
        o.namecli == namecli &&
        o.datestart == datestart &&
        o.datefinalize == datefinalize &&
        o.start == start &&
        o.finished == finished &&
        o.control == control &&
        o.alvo == alvo &&
        o.client == client &&
        o.createdAt == createdAt;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      namecli.hashCode ^
      datestart.hashCode ^
      datefinalize.hashCode ^
      start.hashCode ^
      finished.hashCode ^
      control.hashCode ^
      alvo.hashCode ^
      client.hashCode ^
      createdAt.hashCode;
}
