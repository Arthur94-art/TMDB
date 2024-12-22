import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/core/shared/domain/base_params.dart';
import 'package:tmdb/core/shared/domain/base_usecase.dart';

class PaginatedNotifier<T> extends StateNotifier<AsyncValue<List<T>>> {
  final BaseUsecase<List<T>> _useCase;
  final BaseParams _baseParams;
  int _page = 1;
  bool _isLoading = false;

  PaginatedNotifier(this._useCase, this._baseParams)
      : super(const AsyncValue.data([]));

  Future<void> fetchNextPage() async {
    if (_isLoading) return;

    _isLoading = true;
    _baseParams.setParams = {'page': _page};
    state = _page == 1 ? const AsyncValue.loading() : state;

    final result = await _useCase();
    result.fold(
      (failure) =>
          state = AsyncValue.error(failure.message, StackTrace.current),
      (items) {
        final List<T> newItems = [...state.value ?? [], ...items];
        state = AsyncValue.data(newItems);
        _page++;
        _baseParams.setParams = {'page': _page};
      },
    );

    _isLoading = false;
  }
}
