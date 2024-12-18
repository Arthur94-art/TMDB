import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tmdb/core/styles/main_colors.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: MainColors.cardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ShimmerMoviePoster(),
            _ShimmerMovieTitle(),
            _ShimmerMovieRating(),
          ],
        ),
      ),
    );
  }
}

class _ShimmerMoviePoster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: MainColors.c8C8C8,
        highlightColor: MainColors.f0f0f0,
        child: Container(
          decoration: BoxDecoration(
            color: MainColors.c8C8C8,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

class _ShimmerMovieTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
        baseColor: MainColors.c8C8C8,
        highlightColor: MainColors.f0f0f0,
        child: Container(
          height: 16,
          width: double.infinity,
          color: MainColors.c8C8C8,
        ),
      ),
    );
  }
}

class _ShimmerMovieRating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: MainColors.c8C8C8,
            highlightColor: MainColors.f0f0f0,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: MainColors.c8C8C8,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Shimmer.fromColors(
            baseColor: MainColors.c8C8C8,
            highlightColor: MainColors.f0f0f0,
            child: Container(
              height: 12,
              width: 30,
              color: MainColors.c8C8C8,
            ),
          ),
        ],
      ),
    );
  }
}
