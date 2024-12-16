import 'package:tmdb/core/error/exeptions.dart';
import 'package:tmdb/core/error/failures.dart';

class ErrorMapper {
  static Failure mapExceptionToFailure(Exception exception) {
    if (exception is ServerException) {
      return ServerFailure(exception.message);
    } else if (exception is NetworkException) {
      return NetworkFailure(exception.message);
    } else if (exception is AppException) {
      return UnexpectedFailure(exception.message);
    } else {
      return const UnexpectedFailure('Unknown error occurred');
    }
  }
}
