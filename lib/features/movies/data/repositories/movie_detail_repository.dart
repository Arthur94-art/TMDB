import 'package:dartz/dartz.dart';
import 'package:tmdb/core/error/error_mapper.dart';
import 'package:tmdb/core/error/failures.dart';
import 'package:tmdb/core/shared/data/base_repository.dart';
import 'package:tmdb/features/movies/domain/entities/movie_detail_entity.dart';

class MovieDetailRepository implements BaseRepository<MovieDetailEntity> {
  final BaseRepository<MovieDetailEntity> _repository;
  MovieDetailRepository(this._repository);
  @override
  Future<Either<Failure, MovieDetailEntity>> fetch() async {
    try {
      return await _repository.fetch();
    } catch (e) {
      final failure = ErrorMapper.mapExceptionToFailure(e as Exception);
      return Left(failure);
    }
  }
}
