import 'package:dartz/dartz.dart';
import 'package:tmdb/core/error/failures.dart';
import 'package:tmdb/core/usecases/usecase.dart';
import 'package:tmdb/features/movies/domain/entities/movie_entity.dart';
import 'package:tmdb/features/movies/domain/repositories/movie_repository.dart';

class GetTopRatedMovies extends UseCase<List<MovieEntity>, TopRatedParams> {
  final MovieRepository repository;

  GetTopRatedMovies(this.repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(TopRatedParams params) async {
    return await repository.getTopRatedMovies(page: params.page);
  }
}

class TopRatedParams {
  final int page;

  TopRatedParams({required this.page});
}
