class MovieEntity {
  final int id;
  final String title;
  final String posterPath;
  final double voteAverage;

  const MovieEntity({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
  });
}
