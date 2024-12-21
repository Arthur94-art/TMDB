import 'package:tmdb/core/shared/data/base_remote_data_source.dart';
import 'package:tmdb/core/shared/domain/base_params.dart';
import 'package:tmdb/features/people/data/models/people_model.dart';

class PeopleRemoteDataSourceImpl
    implements BaseRemoteDataSource<List<PeopleModel>> {
  final BaseRemoteDataSourceImpl<List<PeopleModel>> _dataSource;
  PeopleRemoteDataSourceImpl(this._dataSource);

  @override
  Future<List<PeopleModel>> fetch(String path, BaseParams params,
      List<PeopleModel> Function(Map<String, dynamic> json) parser) async {
    try {
      return await _dataSource.fetch(path, params, parser);
    } catch (_) {
      rethrow;
    }
  }
}
