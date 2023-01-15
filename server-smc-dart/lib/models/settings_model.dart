import 'dart:convert';

class SettingsModel {
  dynamic id;
  dynamic description;
  dynamic key;
  dynamic value;
  dynamic content;
  dynamic tenantId;
  SettingsModel({
    this.id,
    this.description,
    this.key,
    this.value,
    this.content,
    this.tenantId,
  });

  SettingsModel copyWith({
    dynamic id,
    dynamic description,
    dynamic key,
    dynamic value,
    dynamic content,
    dynamic tenantId,
  }) {
    return SettingsModel(
      id: id ?? this.id,
      description: description ?? this.description,
      key: key ?? this.key,
      value: value ?? this.value,
      content: content ?? this.content,
      tenantId: tenantId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'key': key,
      'value': value,
      'content': content,
      'tenantId': tenantId,
    };
  }

  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      id: map['id'],
      description: map['description'] ?? '',
      key: map['key'] ?? '',
      value: map['value'] ?? '',
      content: map['content'] ?? '',
      tenantId: map['tenantId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsModel.fromJson(String source) =>
      SettingsModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'SettingsModel(id: $id, description: $description, key: $key, value: $value, tenantId: $tenantId, content: $content)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingsModel &&
        other.id == id &&
        other.description == description &&
        other.key == key &&
        other.value == value &&
        other.content == content &&
        other.tenantId == tenantId;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      description.hashCode ^
      key.hashCode ^
      value.hashCode ^
      content.hashCode ^
      tenantId.hashCode;
}
