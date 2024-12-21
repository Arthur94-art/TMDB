import 'package:dartz/dartz.dart';
import 'package:tmdb/core/error/failures.dart';
import 'package:tmdb/core/shared/data/base_repository.dart';

abstract class BaseUsecase<T> {
  Future<Either<Failure, T>> call();
}

class BaseUseCaseImpl<T> implements BaseUsecase<T> {
  final BaseRepository<T> repository;

  BaseUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, T>> call() async {
    return await repository.fetch();
  }
}
