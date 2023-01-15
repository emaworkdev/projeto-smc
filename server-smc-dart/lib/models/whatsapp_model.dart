// ignore_for_file: avoid_renaming_method_parameters

import 'dart:convert';

class WhatsappModel {
  dynamic id;
  dynamic tenantId;
  dynamic session;
  dynamic qrcode;
  dynamic status;
  dynamic battery;
  dynamic plugged;
  dynamic updatedAt;
  dynamic name;
  dynamic isDefault;
  dynamic retries;
  dynamic token;
  dynamic number;

  WhatsappModel({
    this.id,
    this.tenantId,
    this.session,
    this.qrcode,
    this.status,
    this.battery,
    this.plugged,
    this.updatedAt,
    this.name,
    this.isDefault,
    this.retries,
    this.token,
    this.number,
  });

  WhatsappModel copyWith({
    dynamic id,
    dynamic tenantId,
    dynamic session,
    dynamic qrcode,
    dynamic status,
    dynamic battery,
    dynamic plugged,
    DateTime? updatedAt,
    dynamic name,
    dynamic isDefault,
    dynamic retries,
    dynamic token,
    dynamic number,
  }) {
    return WhatsappModel(
      id: id ?? this.id,
      tenantId: tenantId,
      session: session,
      qrcode: qrcode,
      status: status,
      battery: battery,
      plugged: plugged,
      updatedAt: updatedAt,
      name: name,
      isDefault: isDefault,
      retries: retries,
      token: token,
      number: number,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tenantId': tenantId,
      'session': session,
      'qrcode': qrcode,
      'status': status,
      'battery': battery,
      'plugged': plugged,
      'updatedAt': updatedAt,
      'name': name,
      'isDefault': isDefault,
      'retries': retries,
      'token': token,
      'number': number,
    };
  }

  factory WhatsappModel.fromMap(Map<String, dynamic> map) {
    return WhatsappModel(
      id: map['id'],
      tenantId: map['tenantId'],
      session: map['session'],
      qrcode: map['qrcode'],
      status: map['status'],
      battery: map['battery'],
      plugged: map['plugged'],
      updatedAt: map['updatedAt'],
      name: map['name'],
      isDefault: map['isDefault'],
      retries: map['retries'],
      token: map['token'],
      number: map['number'],
    );
  }

  @override
  String toString() =>
      'WhatsappModel(id: $id, tenantId: $tenantId, session: $session, qrcode: $qrcode, status: $status, battery: $battery, plugged: $plugged, updatedAt: $updatedAt, name: $name, isDefault: $isDefault, retries: $retries, token: $token, number: $number)';

  String toJson() => json.encode(toMap());

  factory WhatsappModel.fromJson(String source) =>
      WhatsappModel.fromMap(json.decode(source));

  static List<WhatsappModel> fromJsonList(List list) {
    return list
        .map<WhatsappModel>((item) => WhatsappModel.fromMap(item))
        .toList();
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is WhatsappModel &&
        o.id == id &&
        o.tenantId == tenantId &&
        o.session == session &&
        o.qrcode == qrcode &&
        o.status == status &&
        o.battery == battery &&
        o.plugged == plugged &&
        o.updatedAt == updatedAt &&
        o.name == name &&
        o.isDefault == isDefault &&
        o.token == token &&
        o.number == number &&
        o.retries == retries;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      tenantId.hashCode ^
      session.hashCode ^
      qrcode.hashCode ^
      status.hashCode ^
      battery.hashCode ^
      plugged.hashCode ^
      updatedAt.hashCode ^
      name.hashCode ^
      isDefault.hashCode ^
      retries.hashCode ^
      number.hashCode ^
      token.hashCode;
}
