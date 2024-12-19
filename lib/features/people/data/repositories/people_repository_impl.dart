import 'package:dartz/dartz.dart';
import 'package:tmdb/core/api/api_paths.dart';
import 'package:tmdb/core/error/error_mapper.dart';
import 'package:tmdb/core/error/failures.dart';
import 'package:tmdb/core/shared/data/base_remote_data_source.dart';
import 'package:tmdb/core/shared/data/base_repository.dart';
import 'package:tmdb/features/people/data/models/people_model.dart';
import 'package:tmdb/features/people/domain/entities/people_entity.dart';

class PeopleRepositoryImpl implements BaseRepository<PeopleEntity> {
  final BaseRemoteDataSource<PeopleModel> _dataSource;
  PeopleRepositoryImpl(this._dataSource);
  @override
  Future<Either<Failure, List<PeopleEntity>>> getItems({int page = 1}) async {
    try {
      final people =
          await _dataSource.getItems(ApiPaths.popularPeople, page: page);
      return Right(people);
    } catch (e) {
      final failure = ErrorMapper.mapExceptionToFailure(e as Exception);
      return Left(failure);
    }
  }
}
