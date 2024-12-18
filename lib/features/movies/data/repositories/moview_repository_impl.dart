import 'package:dartz/dartz.dart';
import 'package:tmdb/core/api/api_paths.dart';
import 'package:tmdb/core/error/error_mapper.dart';
import 'package:tmdb/core/error/failures.dart';
import 'package:tmdb/core/shared/data/base_remote_data_source.dart';
import 'package:tmdb/core/shared/data/base_repository.dart';
import 'package:tmdb/features/movies/domain/entities/movie_entity.dart';

class MovieRepositoryImpl extends BaseRepository<MovieEntity> {
  final BaseRemoteDataSource<MovieEntity> _dataSource;

  MovieRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<MovieEntity>>> getItems({int page = 1}) async {
    try {
      final movies =
          await _dataSource.getItems(ApiPaths.topRatedMovies, page: page);
      return Right(movies);
    } catch (e) {
      return Left(ErrorMapper.mapExceptionToFailure(e as Exception));
    }
  }
}
