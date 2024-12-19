import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/core/widgets/shimmer.dart';
import 'package:tmdb/features/movies/presentation/provider/movie_providers.dart';
import 'package:tmdb/features/movies/presentation/widgets/movie_card.dart';
import 'package:tmdb/features/movies/presentation/widgets/movie_error_widget.dart';

class MovieList extends StatelessWidget {
  final ScrollController scrollController;

  const MovieList({required this.scrollController, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final moviesState = ref.watch(paginatedMoviesProvider);

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
                    key: ValueKey(movie.id),
                    posterPath: movie.posterPath,
                    title: movie.title,
                    rating: movie.voteAverage,
                  );
                },
                childCount: movies.length,
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
            child: MovieErrorWidget(
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
