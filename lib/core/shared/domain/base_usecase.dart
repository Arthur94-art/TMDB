import 'package:dartz/dartz.dart';
import 'package:tmdb/core/error/failures.dart';
import 'package:tmdb/core/shared/data/base_repository.dart';
import 'package:tmdb/core/shared/domain/base_params.dart';

abstract class BaseUsecase<T> {
  Future<Either<Failure, T>> call(BaseParams params);
}

class BaseUseCaseImpl<T> implements BaseUsecase<T> {
  final BaseRepository<T> repository;

  BaseUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, T>> call(BaseParams params) async {
    return await repository.fetch(params);
  }
}
