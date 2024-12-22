import 'package:dartz/dartz.dart';
import 'package:tmdb/core/error/failures.dart';
import 'package:tmdb/core/shared/domain/base_usecase.dart';
import 'package:tmdb/features/movies/domain/entities/movie_entity.dart';

class GetMoviesUsecase implements BaseUsecase<List<MovieEntity>> {
  final BaseUsecase<List<MovieEntity>> _usecase;

  GetMoviesUsecase(this._usecase);

  @override
  Future<Either<Failure, List<MovieEntity>>> call() async {
    return await _usecase();
  }
}

class GetDetailMovieUsecase implements BaseUsecase<MovieEntity> {
  final BaseUsecase<MovieEntity> _useCase;
  GetDetailMovieUsecase(this._useCase);
  @override
  Future<Either<Failure, MovieEntity>> call() async {
    return await _useCase();
  }
}
