import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/core/api/api_paths.dart';
import 'package:tmdb/core/shared/data/base_remote_data_source.dart';
import 'package:tmdb/core/shared/data/base_repository.dart';
import 'package:tmdb/core/shared/domain/base_params.dart';
import 'package:tmdb/core/shared/domain/base_usecase.dart';
import 'package:tmdb/core/shared/providers/api_client_provider.dart';
import 'package:tmdb/features/movies/data/models/movie_result_model.dart';
import 'package:tmdb/features/movies/data/repositories/moview_repository_impl.dart';
import 'package:tmdb/features/movies/domain/entities/movie_entity.dart';
import 'package:tmdb/features/movies/domain/usecases/movie_usecase.dart';
import 'package:tmdb/features/movies/presentation/provider/movie_paginate.dart';

//DataSource
final movieDataSourceProvider =
    Provider<BaseRemoteDataSource<List<MovieModel>>>((ref) {
  return BaseRemoteDataSourceImpl(ref.watch(apiClientProvider));
});

//Repository
final movieRepositoryProvider =
    Provider<BaseRepository<List<MovieEntity>>>((ref) {
  return MovieRepositoryImpl(
    BaseRepositoryImpl(
      ref.watch(movieDataSourceProvider),
      ApiPaths.topRatedMovies,
      (json) {
        return (json['results'] as List)
            .map((item) => MovieModel.fromJson(item))
            .toList();
      },
      MovieListParams(),
    ),
  );
});

//Usecases

final movieUsecasesProvider = Provider<BaseUsecase<List<MovieEntity>>>((ref) {
  return GetMoviesUsecase(BaseUseCaseImpl(ref.watch(movieRepositoryProvider)));
});

// Paginated StateNotifier
final paginatedMoviesProvider = StateNotifierProvider<PaginatedMoviesNotifier,
        AsyncValue<List<MovieEntity>>>(
    (ref) => PaginatedMoviesNotifier(ref.watch(movieUsecasesProvider)));
