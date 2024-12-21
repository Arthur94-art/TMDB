import 'package:dartz/dartz.dart';
import 'package:tmdb/core/error/error_mapper.dart';
import 'package:tmdb/core/error/failures.dart';
import 'package:tmdb/core/shared/data/base_remote_data_source.dart';
import 'package:tmdb/core/shared/domain/base_params.dart';

abstract class BaseRepository<T> {
  Future<Either<Failure, T>> fetch();
}

class BaseRepositoryImpl<T> implements BaseRepository<T> {
  final BaseRemoteDataSource<T> _remoteDataSource;
  final String _path;
  final T Function(Map<String, dynamic> json) _fromJson;
  final BaseParams _params;

  BaseRepositoryImpl(
    this._remoteDataSource,
    this._path,
    this._fromJson,
    this._params,
  );

  @override
  Future<Either<Failure, T>> fetch() async {
    try {
      final items = await _remoteDataSource.fetch(_path, _params, _fromJson);
      return Right(items);
    } catch (e) {
      final failure = ErrorMapper.mapExceptionToFailure(e as Exception);
      return Left(failure);
    }
  }
}
