import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/core/providers/api_client_provider.dart';
import 'package:tmdb/core/shared/data/base_remote_data_source.dart';
import 'package:tmdb/core/shared/data/base_repository.dart';
import 'package:tmdb/core/shared/domain/base_usecase.dart';
import 'package:tmdb/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:tmdb/features/movies/data/models/movie_result_model.dart';
import 'package:tmdb/features/movies/data/repositories/moview_repository_impl.dart';
import 'package:tmdb/features/movies/domain/entities/movie_entity.dart';
import 'package:tmdb/features/movies/domain/usecases/movie_usecase.dart';
import 'package:tmdb/features/movies/presentation/provider/movie_paginate.dart';

// Remote DataSource
final movieRemoteDataSourceProvider =
    Provider<BaseRemoteDataSource<MovieModel>>((ref) {
  return MovieRemoteDataSource(
    ref.watch(apiClientProvider),
    (json) => MovieModel.fromJson(json),
  );
});

// BaseRepository
final movieRepositoryProvider = Provider<BaseRepository<MovieEntity>>((ref) {
  return MovieRepositoryImpl(ref.watch(
    movieRemoteDataSourceProvider,
  ));
});

// UseCase
final getMoviesUseCaseProvider =
    Provider<BaseUsecase<MovieEntity, BaseParams>>((ref) {
  return GetMoviesUsecase(ref.watch(movieRepositoryProvider));
});

// Paginated StateNotifier
final paginatedMoviesProvider = StateNotifierProvider<PaginatedMoviesNotifier,
        AsyncValue<List<MovieEntity>>>(
    (ref) => PaginatedMoviesNotifier(ref.watch(getMoviesUseCaseProvider)));
