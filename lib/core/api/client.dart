import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tmdb/core/api/api_paths.dart';

class ApiClient {
  final Dio _dio;

  ApiClient() : _dio = Dio(BaseOptions(baseUrl: ApiPaths.domain));

  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    final apiKey = dotenv.env['TMDB_API_KEY'];
    queryParams ??= {};
    queryParams['api_key'] = apiKey;
    queryParams['language'] = 'en-US';

    try {
      return await _dio.get(endpoint, queryParameters: queryParams);
    } catch (e) {
      throw Exception("API Error: $e");
    }
  }
}
