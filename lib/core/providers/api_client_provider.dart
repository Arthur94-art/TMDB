import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/core/api/client.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});
