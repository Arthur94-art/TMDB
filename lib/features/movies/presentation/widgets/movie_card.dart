import 'package:flutter/material.dart';
import 'package:tmdb/core/api/api_paths.dart';

class MovieCardWidget extends StatelessWidget {
  final String? posterPath;
  final String title;
  final double rating;

  const MovieCardWidget({
    super.key,
    required this.posterPath,
    required this.title,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4.0,
      color: Colors.white.withOpacity(0.9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _MoviePoster(posterPath: posterPath),
          _MovieTitle(title: title),
          _MovieRating(rating: rating),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final String? posterPath;

  const _MoviePoster({required this.posterPath});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
        child: posterPath != null
            ? Image.network(
                '${ApiPaths.posterPath}$posterPath',
                fit: BoxFit.cover,
              )
            : Container(
                color: Colors.grey[300],
                child: const Icon(
                  Icons.movie,
                  size: 40,
                  color: Colors.grey,
                ),
              ),
      ),
    );
  }
}

class _MovieTitle extends StatelessWidget {
  final String title;

  const _MovieTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
      ),
    );
  }
}

class _MovieRating extends StatelessWidget {
  final double rating;

  const _MovieRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star, size: 16.0, color: Colors.amber),
          const SizedBox(width: 4.0),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
