import 'package:dartz/dartz.dart';
import 'package:tmdb/core/error/failures.dart';
import 'package:tmdb/core/shared/data/base_repository.dart';
import 'package:tmdb/core/shared/domain/base_usecase.dart';
import 'package:tmdb/features/movies/domain/entities/movie_entity.dart';

class GetMoviesUsecase implements BaseUsecase<MovieEntity, BaseParams> {
  final BaseRepository<MovieEntity> _repository;

  GetMoviesUsecase(this._repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(BaseParams params) async {
    return await _repository.getItems(page: params.page);
  }
}
