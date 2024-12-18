import 'package:dartz/dartz.dart';
import 'package:tmdb/core/error/error_mapper.dart';
import 'package:tmdb/core/error/failures.dart';
import 'package:tmdb/core/shared/data/base_remote_data_source.dart';

abstract class BaseRepository<T> {
  Future<Either<Failure, List<T>>> getItems({int page = 1});
}

class BaseRepositoryImpl<T> implements BaseRepository<T> {
  final BaseRemoteDataSource<T> _remoteDataSource;
  final String path;

  BaseRepositoryImpl(this._remoteDataSource, this.path);

  @override
  Future<Either<Failure, List<T>>> getItems({int page = 1}) async {
    try {
      final items = await _remoteDataSource.getItems(path, page: page);
      return Right(items);
    } catch (e) {
      final failure = ErrorMapper.mapExceptionToFailure(e as Exception);
      return Left(failure);
    }
  }
}
