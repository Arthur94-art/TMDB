import 'package:dartz/dartz.dart';
import 'package:tmdb/core/error/error_mapper.dart';
import 'package:tmdb/core/error/failures.dart';
import 'package:tmdb/core/shared/data/base_repository.dart';
import 'package:tmdb/core/shared/domain/base_params.dart';
import 'package:tmdb/features/people/domain/entities/people_entity.dart';

class PeopleRepositoryImpl implements BaseRepository<List<PeopleEntity>> {
  final BaseRepository<List<PeopleEntity>> _dataSource;
  PeopleRepositoryImpl(this._dataSource);
  @override
  Future<Either<Failure, List<PeopleEntity>>> fetch(BaseParams params) async {
    try {
      return await _dataSource.fetch(params);
    } catch (e) {
      final failure = ErrorMapper.mapExceptionToFailure(e as Exception);
      return Left(failure);
    }
  }
}
