import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/core/styles/main_colors.dart';
import 'package:tmdb/core/widgets/loader.dart';
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
                  if (index == movies.length) {
                    return const SizedBox();
                  }
                  final movie = movies[index];
                  return MovieCardWidget(
                    posterPath: movie.posterPath,
                    title: movie.title,
                    rating: movie.voteAverage,
                  );
                },
                childCount: movies.length + 1,
              ),
            ),
          ),
          loading: () => const SliverToBoxAdapter(child: CustomLoader()),
          error: (e, stackTrace) => SliverToBoxAdapter(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Icon(
                    Icons.warning,
                    size: 50,
                    color: MainColors.ratingColor,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$e',
                    style: const TextStyle(
                      color: MainColors.errorColor,
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ref
                          .refresh(paginatedMoviesProvider.notifier)
                          .fetchNextPage();
                    },
                    icon: const Icon(
                      Icons.refresh,
                      size: 50,
                      color: MainColors.cardColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
