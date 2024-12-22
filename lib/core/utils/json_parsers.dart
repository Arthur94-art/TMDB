import 'package:tmdb/features/movies/data/models/movie_result_model.dart';
import 'package:tmdb/features/people/data/models/people_model.dart';

class JsonParsers {
  static List<PeopleModel> peopleListParser(json) {
    return (json['results'] as List)
        .map((e) => PeopleModel.fromJson(e))
        .toList();
  }

  static List<MovieModel> movieListParser(json) {
    return (json['results'] as List)
        .map((e) => MovieModel.fromJson(e))
        .toList();
  }
}
