import 'exception.dart';
import 'failure.dart';

class ErrorHandler {
  ErrorHandler._();

  static Failure handle(dynamic error) {
    if (error is NetworkException) return const NetworkFailure();
    if (error is ServerException) return const ServerFailure();
    if (error is CacheException) return const CacheFailure();
    return Failure(error.toString());
  }
}
