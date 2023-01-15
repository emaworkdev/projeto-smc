class Authorities {
  /// singleton
  factory Authorities() {
    _this ??= Authorities._();
    return _this!;
  }
  static Authorities? _this;
  Authorities._() : super();

  static List<dynamic>? authorities;

  static bool isAuthorities(String cdg) {
    return _verifica(authorities, cdg);
  }
}

_verifica(List<dynamic>? authorities, String cdg) {
  return authorities == null ? false : authorities.contains("'$cdg'");
}
