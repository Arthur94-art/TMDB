import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/core/api/api_paths.dart';
import 'package:tmdb/core/shared/data/base_remote_data_source.dart';
import 'package:tmdb/core/shared/data/base_repository.dart';
import 'package:tmdb/core/shared/domain/base_params.dart';
import 'package:tmdb/core/shared/domain/base_usecase.dart';
import 'package:tmdb/core/shared/providers/api_client_provider.dart';
import 'package:tmdb/core/utils/json_parsers.dart';
import 'package:tmdb/features/people/data/models/people_model.dart';
import 'package:tmdb/features/people/data/repositories/people_repository_impl.dart';
import 'package:tmdb/features/people/domain/entities/people_entity.dart';
import 'package:tmdb/features/people/domain/usecases/people_usecase.dart';
import 'package:tmdb/features/people/presentation/provider/people_paginate.dart';

//remote data sosurce

final peopleRemoteDataSourcProvider =
    Provider<BaseRemoteDataSource<List<PeopleModel>>>((ref) {
  return BaseRemoteDataSourceImpl(ref.watch(apiClientProvider));
});

//repository

final peopleRepositoryProvider = Provider<BaseRepository<List<PeopleEntity>>>(
  (ref) {
    return PeopleRepositoryImpl(
      BaseRepositoryImpl(
        ref.watch(peopleRemoteDataSourcProvider),
        ApiPaths.popularPeople,
        (json) => JsonParsers.peopleListParser(json),
        PeopleListParams(),
      ),
    );
  },
);

//use cases
final peopleUsecaseProvider = Provider<BaseUsecase<List<PeopleEntity>>>((ref) {
  return GetPeopleUsecase(BaseUseCaseImpl(ref.watch(peopleRepositoryProvider)));
});

// Paginated StateNotifier

final paginatedPeopleProvider = StateNotifierProvider<PaginatedPeopleNotifier,
    AsyncValue<List<PeopleEntity>>>((ref) {
  return PaginatedPeopleNotifier(
    ref.watch(peopleUsecaseProvider),
    PeopleListParams(),
  );
});
