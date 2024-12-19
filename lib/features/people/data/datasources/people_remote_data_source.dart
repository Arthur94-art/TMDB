import 'package:tmdb/core/shared/data/base_remote_data_source.dart';
import 'package:tmdb/features/people/data/models/people_model.dart';

class PeopleRemoteDataSourceImpl implements BaseRemoteDataSource<PeopleModel> {
  final BaseRemoteDataSourceImpl<PeopleModel> _dataSource;
  PeopleRemoteDataSourceImpl(this._dataSource);

  @override
  Future<List<PeopleModel>> getItems(String path, {int page = 1}) async {
    try {
      return await _dataSource.getItems(path, page: page);
    } catch (_) {
      rethrow;
    }
  }
}
