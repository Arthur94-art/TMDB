import 'package:flutter/material.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: posterPath != null
                ? ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8.0),
                    ),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500$posterPath',
                      fit: BoxFit.cover,
                    ),
                  )
                : const Center(
                    child: Icon(
                      Icons.movie,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const Icon(Icons.star, size: 16.0, color: Colors.amber),
                const SizedBox(width: 4.0),
                Text(
                  rating.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
