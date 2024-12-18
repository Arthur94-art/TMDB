import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/features/people/domain/entities/people_entity.dart';
import 'package:tmdb/features/people/domain/usecases/people_usecase.dart';

class PaginatedPeopleNotifier
    extends StateNotifier<AsyncValue<List<PeopleEntity>>> {
  final GetPeopleUsecase _useCase;
  int _page = 1;
  bool _isLoading = false;

  PaginatedPeopleNotifier(this._useCase)
      : super(const AsyncValue<List<PeopleEntity>>.data([]));

  Future<void> fetchNextPage() async {
    if (_isLoading) return;

    _isLoading = true;
    final result = await _useCase(PeopleParams(page: _page));
    result.fold(
      (failure) {
        _isLoading = false;
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
      (people) {
        final List<PeopleEntity> newPeople = [...state.value ?? [], ...people];
        _isLoading = false;
        state = AsyncValue.data(newPeople);
        _page++;
      },
    );
  }
}
