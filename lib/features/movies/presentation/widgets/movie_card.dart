import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withOpacity(0.9),
      ),
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

class CachedImage extends StatelessWidget {
  final String? imageUrl;
  final double borderRadius;

  const CachedImage({
    super.key,
    required this.imageUrl,
    this.borderRadius = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: imageUrl != null
          ? CachedNetworkImage(
              imageUrl: imageUrl!,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.grey[300],
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(
                    Icons.broken_image,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
              ),
            )
          : Container(
              color: Colors.grey[300],
              child: const Center(
                child: Icon(
                  Icons.movie,
                  size: 40,
                  color: Colors.grey,
                ),
              ),
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
      child: CachedImage(
        imageUrl:
            posterPath != null ? '${ApiPaths.posterPath}$posterPath' : null,
        borderRadius: 8.0,
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
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
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
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 16),
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
