import 'package:dartz/dartz.dart';
import 'package:tmdb/core/error/failures.dart';
import 'package:tmdb/features/people/domain/entities/people_entity.dart';

abstract class PeopleRepository {
  Future<Either<Failure, List<PeopleEntity>>> getPopularPeople({int page = 1});
}
