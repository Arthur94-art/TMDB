import 'package:tmdb/core/shared/data/base_remote_data_source.dart';
import 'package:tmdb/core/shared/domain/base_params.dart';
import 'package:tmdb/features/movies/data/models/movie_detail_model.dart';

class MovieDetailDataSource implements BaseRemoteDataSource<MovieDetailModel> {
  final BaseRemoteDataSource<MovieDetailModel> _dataSource;
  MovieDetailDataSource(this._dataSource);

  @override
  Future<MovieDetailModel> fetch(String path, BaseParams params,
      MovieDetailModel Function(Map<String, dynamic> json) parser) async {
    try {
      final response = await _dataSource.fetch(path, params, parser);
      return response;
    } catch (_) {
      rethrow;
    }
  }
}
