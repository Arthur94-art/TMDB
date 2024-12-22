class MovieDetailEntity {
  final int id;
  final String title;
  final String releaseDate;
  final String overview;
  final String backdropPath;
  final double voteAverage;
  MovieDetailEntity({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.overview,
    required this.backdropPath,
    required this.voteAverage,
  });
}
