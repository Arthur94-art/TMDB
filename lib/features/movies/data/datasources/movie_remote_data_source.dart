import 'package:tmdb/core/shared/data/base_remote_data_source.dart';
import 'package:tmdb/features/movies/data/models/movie_result_model.dart';

class MovieRemoteDataSource implements BaseRemoteDataSource<MovieModel> {
  final BaseRemoteDataSourceImpl<MovieModel> _dataSource;
  MovieRemoteDataSource(this._dataSource);

  @override
  Future<List<MovieModel>> getItems(String path, {int page = 1}) async {
    try {
      return await _dataSource.getItems(path, page: page);
    } catch (_) {
      rethrow;
    }
  }
}
