import 'package:dartz/dartz.dart';
import 'package:tmdb/core/error/error_mapper.dart';
import 'package:tmdb/core/error/failures.dart';
import 'package:tmdb/features/people/data/datasources/people_remote_data_source.dart';
import 'package:tmdb/features/people/domain/entities/people_entity.dart';
import 'package:tmdb/features/people/domain/repositories/people_repository.dart';

class PeopleRepositoryImpl extends PeopleRepository {
  final PeopleRemoteDataSource _remoteDataSource;
  PeopleRepositoryImpl(this._remoteDataSource);
  @override
  Future<Either<Failure, List<PeopleEntity>>> getPopularPeople(
      {int page = 1}) async {
    try {
      final people = await _remoteDataSource.getTopRatedMovies(page: page);
      return Right(people);
    } catch (e) {
      final failure = ErrorMapper.mapExceptionToFailure(e as Exception);
      return Left(failure);
    }
  }
}
