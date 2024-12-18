import 'package:tmdb/core/shared/presentation/base_paginate_notifire.dart';
import 'package:tmdb/features/people/domain/entities/people_entity.dart';

class PaginatedPeopleNotifier extends PaginatedNotifier<PeopleEntity> {
  PaginatedPeopleNotifier(super.useCase);
}
