import 'package:tmdb/core/shared/data/base_remote_data_source.dart';
import 'package:tmdb/features/movies/data/models/movie_result_model.dart';

class MovieRemoteDataSource extends BaseRemoteDataSourceImpl<MovieModel> {
  MovieRemoteDataSource(super.apiClient, super.fromJson);
}
