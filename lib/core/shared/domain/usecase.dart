import 'package:dartz/dartz.dart';
import 'package:tmdb/core/error/failures.dart';

abstract class UseCase<Type, BaseParams> {
  Future<Either<Failure, Type>> call(BaseParams params);
}
