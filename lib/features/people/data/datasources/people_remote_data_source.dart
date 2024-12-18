import 'package:tmdb/core/api/api_paths.dart';
import 'package:tmdb/core/api/client.dart';
import 'package:tmdb/features/people/data/models/people_model.dart';
import 'package:tmdb/features/people/domain/entities/people_entity.dart';

abstract class PeopleRemoteDataSource {
  Future<List<PeopleEntity>> getTopRatedMovies({int page = 1});
}

class PeopleRemoteDataSourceImpl implements PeopleRemoteDataSource {
  final ApiClient _apiClient;

  PeopleRemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<PeopleEntity>> getTopRatedMovies({int page = 1}) async {
    try {
      final response = await _apiClient.get(
        ApiPaths.popularPeople,
        queryParams: {'page': page},
      );

      return (response.data['results'] as List)
          .map((json) => PeopleModel.fromJson(json))
          .toList();
    } catch (_) {
      rethrow;
    }
  }
}
