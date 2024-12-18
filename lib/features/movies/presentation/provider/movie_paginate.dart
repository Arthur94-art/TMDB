import 'package:tmdb/core/shared/providers/base_paginate_notifire.dart';
import 'package:tmdb/features/movies/domain/entities/movie_entity.dart';

class PaginatedMoviesNotifier extends PaginatedNotifier<MovieEntity> {
  PaginatedMoviesNotifier(super.useCase);
}
