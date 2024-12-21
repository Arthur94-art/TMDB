import 'package:tmdb/core/shared/data/base_remote_data_source.dart';
import 'package:tmdb/core/shared/domain/base_params.dart';
import 'package:tmdb/features/movies/data/models/movie_result_model.dart';

class MovieRemoteDataSource implements BaseRemoteDataSource<List<MovieModel>> {
  final BaseRemoteDataSource<List<MovieModel>> _dataSource;

  const MovieRemoteDataSource(this._dataSource);

  @override
  Future<List<MovieModel>> fetch(String path, BaseParams params,
      List<MovieModel> Function(Map<String, dynamic> json) parser) async {
    try {
      return await _dataSource.fetch(path, params, parser);
    } catch (_) {
      rethrow;
    }
  }
}
