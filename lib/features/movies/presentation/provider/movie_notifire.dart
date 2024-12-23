import 'package:tmdb/core/shared/providers/base_notifire.dart';
import 'package:tmdb/features/movies/domain/entities/movie_detail_entity.dart';

class BaseMoviesNotifier extends BaseNotifier<MovieDetailEntity> {
  BaseMoviesNotifier(super.useCase, super._id);
}
