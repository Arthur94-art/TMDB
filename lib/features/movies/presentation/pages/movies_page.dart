import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/core/styles/main_colors.dart';
import 'package:tmdb/core/widgets/banner.dart';
import 'package:tmdb/features/movies/presentation/provider/movie_providers.dart';
import 'package:tmdb/features/movies/presentation/widgets/movie_card.dart';
import 'package:tmdb/features/people/presentation/pages/people_page.dart';

class TopRatedMoviesPage extends ConsumerWidget {
  const TopRatedMoviesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsyncValue = ref.watch(topRatedMoviesProvider(1));

    return Scaffold(
      backgroundColor: MainColors.background,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Movies'),
            centerTitle: true,
            floating: true,
            pinned: true,
            foregroundColor: Color.fromARGB(255, 208, 214, 218),
            backgroundColor: Color(0xff032541),
          ),
          const SliverToBoxAdapter(
            child: BannerWidget(),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _PeoplePageHeader(),
          ),
          moviesAsyncValue.when(
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
                    final movie = movies[index];
                    return MovieCardWidget(
                      posterPath: movie.posterPath,
                      title: movie.title,
                      rating: movie.voteAverage,
                    );
                  },
                  childCount: movies.length,
                ),
              ),
            ),
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, _) => SliverFillRemaining(
              child: Center(
                child: Text(
                  'Error: ${error.toString()}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PeoplePageHeader extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 100.0;
  @override
  double get maxExtent => 100.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return const SizedBox(
      height: 100,
      child: PeoplePage(),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
