import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/core/api/api_paths.dart';
import 'package:tmdb/core/shared/data/base_remote_data_source.dart';
import 'package:tmdb/core/shared/data/base_repository.dart';
import 'package:tmdb/core/shared/domain/base_usecase.dart';
import 'package:tmdb/core/shared/providers/api_client_provider.dart';
import 'package:tmdb/core/utils/json_parsers.dart';
import 'package:tmdb/features/movies/data/datasources/movie_detail_data_source.dart';
import 'package:tmdb/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:tmdb/features/movies/data/models/movie_detail_model.dart';
import 'package:tmdb/features/movies/data/models/movie_result_model.dart';
import 'package:tmdb/features/movies/data/repositories/movie_detail_repository.dart';
import 'package:tmdb/features/movies/data/repositories/moview_repository_impl.dart';
import 'package:tmdb/features/movies/domain/entities/movie_detail_entity.dart';
import 'package:tmdb/features/movies/domain/entities/movie_entity.dart';
import 'package:tmdb/features/movies/domain/usecases/movie_usecase.dart';
import 'package:tmdb/features/movies/presentation/provider/movie_notifire.dart';
import 'package:tmdb/features/movies/presentation/provider/movie_paginate.dart';

//DataSource
final movieDataSourceProvider =
    Provider<BaseRemoteDataSource<List<MovieModel>>>(
  (ref) {
    return MovieRemoteDataSource(
      BaseRemoteDataSourceImpl(
        ref.watch(apiClientProvider),
      ),
    );
  },
);

final movieDetailDataSourceProvider =
    Provider<BaseRemoteDataSource<MovieDetailModel>>(
  (ref) {
    return MovieDetailDataSource(
      BaseRemoteDataSourceImpl(
        ref.watch(apiClientProvider),
      ),
    );
  },
);

//Repository
final movieRepositoryProvider = Provider<BaseRepository<List<MovieEntity>>>(
  (ref) {
    return MovieRepositoryImpl(
      BaseRepositoryImpl(
        ref.watch(movieDataSourceProvider),
        ApiPaths.topRatedMovies,
        (json) => JsonParsers.movieListParser(json),
      ),
    );
  },
);

final movieDetailRepositoryProvider =
    Provider.family<BaseRepository<MovieDetailEntity>, int>(
  (ref, id) {
    return MovieDetailRepository(
      BaseRepositoryImpl(
        ref.watch(movieDetailDataSourceProvider),
        ApiPaths.movieDetail(id),
        (json) => JsonParsers.movieModelParser(json),
      ),
    );
  },
);

//Usecases

final movieUsecasesProvider = Provider<BaseUsecase<List<MovieEntity>>>(
  (ref) {
    return GetMoviesUsecase(
      BaseUseCaseImpl(
        ref.watch(movieRepositoryProvider),
      ),
    );
  },
);

final movieDetailUsecaseProvider =
    Provider.family<BaseUsecase<MovieDetailEntity>, int>(
  (ref, id) {
    return GetDetailMovieUsecase(
      BaseUseCaseImpl(
        ref.watch(movieDetailRepositoryProvider(id)),
      ),
    );
  },
);

// Paginated StateNotifier
final paginatedMoviesProvider = StateNotifierProvider<PaginatedMoviesNotifier,
    AsyncValue<List<MovieEntity>>>(
  (ref) => PaginatedMoviesNotifier(
    ref.watch(movieUsecasesProvider),
  ),
);
final detailMoviesProvider = StateNotifierProvider.family<BaseMoviesNotifier,
    AsyncValue<MovieDetailEntity>, int>(
  (ref, id) => BaseMoviesNotifier(
    ref.watch(movieDetailUsecaseProvider(id)),
    id,
  ),
);
