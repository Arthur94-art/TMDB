import 'package:dartz/dartz.dart';
import 'package:tmdb/core/error/error_mapper.dart';
import 'package:tmdb/core/error/failures.dart';
import 'package:tmdb/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:tmdb/features/movies/domain/entities/movie_entity.dart';
import 'package:tmdb/features/movies/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource _remoteDataSource;

  MovieRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<MovieEntity>>> getTopRatedMovies(
      {int page = 1}) async {
    try {
      final movies = await _remoteDataSource.getTopRatedMovies(page: page);
      return Right(movies);
    } catch (e) {
      final failure = ErrorMapper.mapExceptionToFailure(e as Exception);
      return Left(failure);
    }
  }
}
