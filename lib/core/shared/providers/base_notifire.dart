import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/core/shared/domain/base_params.dart';
import 'package:tmdb/core/shared/domain/base_usecase.dart';

class BaseNotifier<T> extends StateNotifier<AsyncValue<T>> {
  final BaseUsecase<T> _useCase;
  final int _id;
  bool _isLoading = false;

  BaseNotifier(this._useCase, this._id) : super(const AsyncValue.loading());

  Future<void> fetchNextPage() async {
    if (_isLoading) return;

    _isLoading = true;

    final result = await _useCase(MovieDetailParams(_id));
    result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
        _isLoading = false;
      },
      (items) {
        state = AsyncValue.data(items); // Виправлення, щоб уникнути кастування
      },
    );

    _isLoading = false;
  }
}
