import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/core/providers/api_client_provider.dart';
import 'package:tmdb/core/usecases/usecase.dart';
import 'package:tmdb/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:tmdb/features/movies/data/repositories/moview_repository_impl.dart';
import 'package:tmdb/features/movies/domain/entities/movie_entity.dart';
import 'package:tmdb/features/movies/domain/repositories/movie_repository.dart';
import 'package:tmdb/features/movies/domain/usecases/movie_usecase.dart';

final movieRemoteDataSourceProvider = Provider<MovieRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return MovieRemoteDataSourceImpl(apiClient);
});

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final remoteDataSource = ref.watch(movieRemoteDataSourceProvider);
  return MovieRepositoryImpl(remoteDataSource);
});

final movieUseCaseProvider = Provider<UseCase>((ref) {
  final repository = ref.watch(movieRepositoryProvider);
  return GetMoviesUsecase(repository);
});

final topRatedMoviesProvider =
    FutureProvider.family<List<MovieEntity>, int>((ref, page) async {
  final useCase = ref.watch(movieUseCaseProvider);
  return useCase.call(TopRatedParams(page: page)).then((result) {
    return result.fold(
      (failure) => throw Exception(failure.message),
      (movies) => movies,
    );
  });
});
