import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/core/providers/api_client_provider.dart';
import 'package:tmdb/core/shared/data/base_remote_data_source.dart';
import 'package:tmdb/core/shared/data/base_repository.dart';
import 'package:tmdb/core/shared/domain/base_usecase.dart';
import 'package:tmdb/features/people/data/datasources/people_remote_data_source.dart';
import 'package:tmdb/features/people/data/models/people_model.dart';
import 'package:tmdb/features/people/data/repositories/people_repository_impl.dart';
import 'package:tmdb/features/people/domain/entities/people_entity.dart';
import 'package:tmdb/features/people/domain/usecases/people_usecase.dart';
import 'package:tmdb/features/people/presentation/provider/people_paginate.dart';

// Remote DataSource
final peopleRemoteDataSourceProvider =
    Provider<BaseRemoteDataSource<PeopleModel>>((ref) {
  return PeopleRemoteDataSourceImpl(
      ref.watch(apiClientProvider), (json) => PeopleModel.fromJson(json));
});

// BaseRepository
final peopleRepositoryProvider = Provider<BaseRepository<PeopleEntity>>((ref) {
  return PeopleRepositoryImpl(ref.watch(peopleRemoteDataSourceProvider));
});

// UseCase
final getPeopleUseCaseProvider =
    Provider<BaseUsecase<PeopleEntity, BaseParams>>((ref) {
  return GetPeopleUsecase(ref.watch(peopleRepositoryProvider));
});

// Paginated StateNotifier
final paginatedPeopleProvider = StateNotifierProvider<PaginatedPeopleNotifier,
    AsyncValue<List<PeopleEntity>>>((ref) {
  return PaginatedPeopleNotifier(ref.watch(getPeopleUseCaseProvider));
});
