import 'package:dartz/dartz.dart';
import 'package:tmdb/core/error/failures.dart';
import 'package:tmdb/core/shared/domain/base_usecase.dart';
import 'package:tmdb/features/people/domain/entities/people_entity.dart';

class GetPeopleUsecase implements BaseUsecase<List<PeopleEntity>> {
  final BaseUsecase<List<PeopleEntity>> _useCase;

  GetPeopleUsecase(this._useCase);

  @override
  Future<Either<Failure, List<PeopleEntity>>> call() async {
    return await _useCase();
  }
}
