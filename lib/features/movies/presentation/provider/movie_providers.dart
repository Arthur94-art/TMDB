import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/core/providers/api_client_provider.dart';
import 'package:tmdb/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:tmdb/features/movies/data/repositories/moview_repository_impl.dart';
import 'package:tmdb/features/movies/domain/entities/movie_entity.dart';
import 'package:tmdb/features/movies/domain/repositories/movie_repository.dart';

final movieRemoteDataSourceProvider = Provider<MovieRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return MovieRemoteDataSourceImpl(apiClient);
});

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final remoteDataSource = ref.watch(movieRemoteDataSourceProvider);
  return MovieRepositoryImpl(remoteDataSource);
});

final topRatedMoviesProvider =
    FutureProvider.family<List<MovieEntity>, int>((ref, page) async {
  final repository = ref.watch(movieRepositoryProvider);
  return repository.getTopRatedMovies(page: page).then((result) {
    return result.fold(
      (failure) => throw Exception(failure.message),
      (movies) => movies,
    );
  });
});
