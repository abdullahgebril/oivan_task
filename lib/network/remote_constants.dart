class RemoteConstants {
  const RemoteConstants._();

  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
  static const int numberOfRetries = 3;
}
