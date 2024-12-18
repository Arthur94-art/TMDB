import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/core/styles/main_colors.dart';
import 'package:tmdb/core/widgets/shimmer.dart';
import 'package:tmdb/features/movies/presentation/provider/movie_providers.dart';
import 'package:tmdb/features/movies/presentation/widgets/movie_card.dart';

class MovieList extends StatelessWidget {
  final ScrollController scrollController;

  const MovieList({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final moviesState = ref.watch(paginatedMoviesProvider);
        final isLoadingMore =
            ref.watch(paginatedMoviesProvider.notifier).isLoadingMore;

        return moviesState.when(
          data: (movies) => SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.6,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index >= movies.length) {
                    return const ShimmerCard();
                  }
                  final movie = movies[index];
                  return MovieCardWidget(
                    posterPath: movie.posterPath,
                    title: movie.title,
                    rating: movie.voteAverage,
                  );
                },
                childCount: movies.length + (isLoadingMore ? 6 : 0),
              ),
            ),
          ),
          loading: () => SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.6,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => const ShimmerCard(),
                childCount: 6,
              ),
            ),
          ),
          error: (e, stackTrace) => SliverToBoxAdapter(
            child: _BuildErrorWidget(
              error: e,
              onRefresh: () {
                ref.refresh(paginatedMoviesProvider.notifier).fetchNextPage();
              },
            ),
          ),
        );
      },
    );
  }
}

class _BuildErrorWidget extends StatelessWidget {
  final Object _error;
  final VoidCallback _onRefresh;
  const _BuildErrorWidget(
      {required Object error, required VoidCallback onRefresh})
      : _error = error,
        _onRefresh = onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.warning,
          size: 50,
          color: MainColors.ratingColor,
        ),
        Text(
          '$_error',
          style: const TextStyle(
            color: MainColors.errorColor,
            fontSize: 20,
          ),
        ),
        IconButton(
          onPressed: _onRefresh,
          icon: const Icon(
            Icons.refresh,
            size: 40,
            color: MainColors.cardColor,
          ),
        )
      ],
    );
  }
}
