import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final int id;
  final String title;
  final String posterPath;
  final double rating;

  const MovieEntity({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.rating,
  });

  @override
  List<Object?> get props => [id, title, posterPath, rating];
}
