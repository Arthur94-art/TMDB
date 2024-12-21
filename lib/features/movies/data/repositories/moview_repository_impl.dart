import 'package:dartz/dartz.dart';
import 'package:tmdb/core/error/error_mapper.dart';
import 'package:tmdb/core/error/failures.dart';
import 'package:tmdb/core/shared/data/base_repository.dart';
import 'package:tmdb/features/movies/domain/entities/movie_entity.dart';

class MovieRepositoryImpl implements BaseRepository<List<MovieEntity>> {
  final BaseRepositoryImpl<List<MovieEntity>> _repositoryImpl;

  MovieRepositoryImpl(this._repositoryImpl);

  @override
  Future<Either<Failure, List<MovieEntity>>> fetch() async {
    try {
      return await _repositoryImpl.fetch();
    } catch (e) {
      return Left(ErrorMapper.mapExceptionToFailure(e as Exception));
    }
  }
}
