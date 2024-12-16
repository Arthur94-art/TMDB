class AppException implements Exception {
  final String message;

  AppException(this.message);
}

class ServerException extends AppException {
  ServerException([super.message = 'Server error']);
}

class NetworkException extends AppException {
  NetworkException([super.message = 'No Internet connection']);
}

class UnexpectedException extends AppException {
  UnexpectedException([super.message = 'Unexpected error']);
}
