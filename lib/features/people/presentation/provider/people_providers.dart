import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/core/providers/api_client_provider.dart';
import 'package:tmdb/features/people/data/datasources/people_remote_data_source.dart';
import 'package:tmdb/features/people/data/repositories/people_repository_impl.dart';
import 'package:tmdb/features/people/domain/entities/people_entity.dart';
import 'package:tmdb/features/people/domain/repositories/people_repository.dart';
import 'package:tmdb/features/people/domain/usecases/people_usecase.dart';
import 'package:tmdb/features/people/presentation/provider/people_paginate.dart';

// Remote DataSource
final peopleRemoteDataSourceProvider = Provider<PeopleRemoteDataSource>((ref) {
  return PeopleRemoteDataSourceImpl(ref.watch(apiClientProvider));
});

// Repository
final peopleRepositoryProvider = Provider<PeopleRepository>((ref) {
  return PeopleRepositoryImpl(ref.watch(peopleRemoteDataSourceProvider));
});

// UseCase
final getPeopleUseCaseProvider = Provider<GetPeopleUsecase>((ref) {
  return GetPeopleUsecase(ref.watch(peopleRepositoryProvider));
});

// Paginated StateNotifier
final paginatedPeopleProvider = StateNotifierProvider<PaginatedPeopleNotifier,
    AsyncValue<List<PeopleEntity>>>((ref) {
  return PaginatedPeopleNotifier(ref.watch(getPeopleUseCaseProvider));
});
