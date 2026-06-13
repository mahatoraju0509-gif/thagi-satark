class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('Internet जडान छैन');
}

class ServerFailure extends Failure {
  const ServerFailure() : super('Server मा समस्या छ');
}

class CacheFailure extends Failure {
  const CacheFailure() : super('Data load गर्न सकिएन');
}

class NotFoundFailure extends Failure {
  const NotFoundFailure() : super('डाटा भेटिएन');
}
