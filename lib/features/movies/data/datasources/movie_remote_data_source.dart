import 'package:tmdb/core/api/client.dart';
import 'package:tmdb/features/movies/data/models/movie_result_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTopRatedMovies({int page = 1});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ApiClient _apiClient;

  MovieRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<MovieModel>> getTopRatedMovies({int page = 1}) async {
    final response = await _apiClient.get(
      ApiPaths.topRatedMovies,
      queryParams: {'page': page},
    );

    return (response.data['results'] as List)
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }
}
