import 'package:tmdb/core/api/client.dart';

abstract class BaseRemoteDataSource<T> {
  Future<List<T>> getItems(String path, {int page = 1});
}

class BaseRemoteDataSourceImpl<T> implements BaseRemoteDataSource<T> {
  final ApiClient _apiClient;
  final T Function(Map<String, dynamic> json) fromJson;

  BaseRemoteDataSourceImpl(this._apiClient, this.fromJson);

  @override
  Future<List<T>> getItems(String path, {int page = 1}) async {
    try {
      final response = await _apiClient.get(
        path,
        queryParams: {'page': page},
      );
      return (response.data['results'] as List)
          .map((json) => fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
