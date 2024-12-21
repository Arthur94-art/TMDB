import 'package:tmdb/core/api/client.dart';
import 'package:tmdb/core/shared/domain/base_params.dart';

abstract class BaseRemoteDataSource<T> {
  Future<T> fetch(String path, BaseParams params,
      T Function(Map<String, dynamic> json) parser);
}

class BaseRemoteDataSourceImpl<T> implements BaseRemoteDataSource<T> {
  final ApiClient _apiClient;

  BaseRemoteDataSourceImpl(this._apiClient);

  @override
  Future<T> fetch(
    String path,
    BaseParams params,
    Function(Map<String, dynamic> json) parser,
  ) async {
    try {
      final response = await _apiClient.get(
        path,
        queryParams: params.params,
      );
      return parser(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
