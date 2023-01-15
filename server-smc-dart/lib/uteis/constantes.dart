class Constantes {
  /// singleton
  factory Constantes() {
    _this ??= Constantes._();
    return _this!;
  }
  static Constantes? _this;
  Constantes._() : super();

  static String apiToken = '';
  static String apiTokenClient = '';
}
