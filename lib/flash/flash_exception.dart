class FlashException implements Exception {
  //
  final String cause;

  FlashException(this.cause);

  @override
  String toString() => 'FlashException(cause: $cause)';
}
