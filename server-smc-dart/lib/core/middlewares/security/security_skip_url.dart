class SecuritySkipUrl {
  String url;
  String method;

  SecuritySkipUrl({
    required this.url,
    required this.method,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SecuritySkipUrl &&
        other.url == url &&
        other.method == method;
  }

  @override
  int get hashCode => url.hashCode ^ method.hashCode;
}
