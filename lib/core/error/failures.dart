abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server failure']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network failure']);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = 'Unexpected failure']);
}
