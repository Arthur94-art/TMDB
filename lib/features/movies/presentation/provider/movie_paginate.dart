import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/features/movies/domain/entities/movie_entity.dart';
import 'package:tmdb/features/movies/domain/usecases/movie_usecase.dart';

class PaginatedMoviesNotifier extends StateNotifier<List<MovieEntity>> {
  final GetMoviesUsecase _useCase;
  int _page = 1;
  bool _isLoading = false;

  PaginatedMoviesNotifier(this._useCase) : super([]);

  Future<void> fetchNextPage() async {
    if (_isLoading) return;

    _isLoading = true;
    try {
      final result = await _useCase(TopRatedParams(page: _page));
      result.fold(
        (failure) => log('Error: ${failure.message}'),
        (movies) {
          state = [...state, ...movies];
          _page++;
        },
      );
    } catch (e) {
      log('Error: $e');
    } finally {
      _isLoading = false;
    }
  }
}
