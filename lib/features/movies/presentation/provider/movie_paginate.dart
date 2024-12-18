import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/features/movies/domain/entities/movie_entity.dart';
import 'package:tmdb/features/movies/domain/usecases/movie_usecase.dart';

class PaginatedMoviesNotifier
    extends StateNotifier<AsyncValue<List<MovieEntity>>> {
  final GetMoviesUsecase _useCase;
  int _page = 1;
  bool _isLoading = false;
  bool isLoadingMore = false;

  PaginatedMoviesNotifier(this._useCase)
      : super(const AsyncValue<List<MovieEntity>>.data([]));

  Future<void> fetchNextPage() async {
    if (_isLoading) return;

    _isLoading = true;
    if (_page == 1) {
      state = const AsyncValue.loading();
    } else {
      isLoadingMore = true;
    }

    try {
      final result = await _useCase(TopRatedParams(page: _page));
      result.fold(
        (failure) {
          state = AsyncValue.error(failure.message, StackTrace.current);
        },
        (movies) {
          final List<MovieEntity> newMovies = [...state.value ?? [], ...movies];

          state = AsyncValue.data(newMovies);
          _page++;
        },
      );
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    } finally {
      _isLoading = false;
      isLoadingMore = false;
    }
  }
}
