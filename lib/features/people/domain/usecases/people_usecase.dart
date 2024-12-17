import 'package:dartz/dartz.dart';
import 'package:tmdb/core/error/failures.dart';
import 'package:tmdb/core/usecases/usecase.dart';
import 'package:tmdb/features/people/domain/entities/people_entity.dart';
import 'package:tmdb/features/people/domain/repositories/people_repository.dart';

class GetPeopleUsecase extends UseCase<List<PeopleEntity>, PeopleParams> {
  final PeopleRepository repository;

  GetPeopleUsecase(this.repository);

  @override
  Future<Either<Failure, List<PeopleEntity>>> call(PeopleParams params) async {
    return await repository.getPopularPeople(page: params.page);
  }
}

class PeopleParams {
  final int page;

  PeopleParams({required this.page});
}
