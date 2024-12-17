import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tmdb/core/error/exeptions.dart';

import 'api_paths.dart';

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
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      throw UnexpectedException('Unexpected error: $e');
    }

    throw UnexpectedException(
        'Unexpected error: No response or exception thrown.');
  }

  void _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionError) {
      throw NetworkException('No internet connection');
    } else if (e.response != null && e.response?.statusCode == 500) {
      throw ServerException('Internal server error');
    } else if (e.response != null) {
      throw ServerException('Error: ${e.response?.statusCode}');
    } else {
      throw UnexpectedException('Unknown error');
    }
  }
}
