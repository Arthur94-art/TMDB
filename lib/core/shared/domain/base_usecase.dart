import 'package:dartz/dartz.dart';
import 'package:tmdb/core/error/failures.dart';
import 'package:tmdb/core/shared/data/base_repository.dart';

abstract class BaseUsecase<T, BaseParams> {
  Future<Either<Failure, List<T>>> call(BaseParams params);
}

class BaseUseCaseImpl<T> implements BaseUsecase<T, BaseParams> {
  final BaseRepository<T> repository;

  BaseUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<T>>> call(BaseParams params) async {
    return await repository.getItems(page: params.page);
  }
}

class BaseParams {
  final int page;

  BaseParams({required this.page});
}
