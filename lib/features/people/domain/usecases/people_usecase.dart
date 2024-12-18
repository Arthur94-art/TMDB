import 'package:dartz/dartz.dart';
import 'package:tmdb/core/error/failures.dart';
import 'package:tmdb/core/shared/data/base_repository.dart';
import 'package:tmdb/core/shared/domain/base_usecase.dart';
import 'package:tmdb/features/people/domain/entities/people_entity.dart';

class GetPeopleUsecase extends BaseUsecase<PeopleEntity, BaseParams> {
  final BaseRepository<PeopleEntity> _repository;

  GetPeopleUsecase(this._repository);

  @override
  Future<Either<Failure, List<PeopleEntity>>> call(BaseParams params) async {
    return await _repository.getItems(page: params.page);
  }
}
