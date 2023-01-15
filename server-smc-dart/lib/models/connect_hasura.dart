import 'dart:convert';

class ConnectHasura {
  dynamic id;
  dynamic connected;
  String? qrcode;
  String? event;
  String? status;
  String? session;

  ConnectHasura(
      {this.connected,
      this.qrcode,
      this.event,
      this.status,
      this.id,
      this.session});

  ConnectHasura copyWith({
    dynamic connected,
    dynamic qrcode,
    dynamic event,
    dynamic status,
    String? id,
    String? session,
  }) {
    return ConnectHasura(
      id: id ?? this.id,
      connected: connected ?? this.connected,
      qrcode: qrcode ?? this.qrcode,
      event: event ?? this.event,
      status: status ?? this.status,
      session: session ?? this.session,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'connected': connected,
      'qrcode': qrcode,
      'event': event,
      'status': status,
      'session': session,
    };
  }

  factory ConnectHasura.fromMap(Map<String, dynamic> map) {
    return ConnectHasura(
      id: map['id'],
      connected: map['connected'],
      qrcode: map['qrcode'],
      event: map['event'],
      status: map['status'],
      session: map['session'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ConnectHasura.fromJson(String source) =>
      ConnectHasura.fromMap(json.decode(source));

  static List<ConnectHasura> fromJsonList(List list) {
    return list
        .map<ConnectHasura>((item) => ConnectHasura.fromMap(item))
        .toList();
  }

  @override
  String toString() =>
      'ConnectHasura(id: $id, connected: $connected, qrcode: $qrcode, event: $event, status: $status, session: $session),';

  @override
  // ignore: avoid_renaming_method_parameters
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ConnectHasura &&
        o.id == id &&
        o.connected == connected &&
        o.qrcode == qrcode &&
        o.event == event &&
        o.session == session &&
        o.status == status;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      connected.hashCode ^
      qrcode.hashCode ^
      event.hashCode ^
      session.hashCode ^
      status.hashCode;
}
