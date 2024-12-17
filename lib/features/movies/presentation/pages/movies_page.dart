import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/features/movies/presentation/provider/movie_providers.dart';
import 'package:tmdb/features/movies/presentation/widgets/movie_card.dart';

class TopRatedMoviesPage extends ConsumerWidget {
  const TopRatedMoviesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsyncValue = ref.watch(topRatedMoviesProvider(1));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
        centerTitle: true,
      ),
      body: moviesAsyncValue.when(
        data: (movies) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.7,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return MovieCardWidget(
                posterPath: movie.posterPath,
                title: movie.title,
                rating: movie.voteAverage,
              );
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text(
            'Error: ${error.toString()}',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
