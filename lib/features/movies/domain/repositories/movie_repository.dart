import 'package:dartz/dartz.dart';
import 'package:tmdb/core/error/failures.dart';
import 'package:tmdb/features/movies/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getTopRatedMovies({int page = 1});
}
