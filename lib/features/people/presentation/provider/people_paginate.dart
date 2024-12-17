import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/features/people/domain/entities/people_entity.dart';
import 'package:tmdb/features/people/domain/usecases/people_usecase.dart';

class PaginatedPeopleNotifier extends StateNotifier<List<PeopleEntity>> {
  final GetPeopleUsecase _useCase;
  int _page = 1;
  bool _isLoading = false;

  PaginatedPeopleNotifier(this._useCase) : super([]);

  Future<void> fetchNextPage() async {
    if (_isLoading) return;

    _isLoading = true;
    try {
      final result = await _useCase(PeopleParams(page: _page));
      result.fold(
        (failure) => log('+++: ${failure.message}'),
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