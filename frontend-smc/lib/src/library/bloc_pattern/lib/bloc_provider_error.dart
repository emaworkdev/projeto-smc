class BlocProviderException implements Exception {
  String cause;
  BlocProviderException(this.cause);

  @override
  String toString() {
    return "BlocProvider: $cause";
  }

}