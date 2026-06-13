class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException() : super('Internet जडान छैन');
}

class ServerException extends AppException {
  const ServerException() : super('Server मा समस्या छ');
}

class CacheException extends AppException {
  const CacheException() : super('Data load गर्न सकिएन');
}
