import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/core/styles/main_colors.dart';
import 'package:tmdb/core/widgets/banner.dart';
import 'package:tmdb/features/movies/presentation/provider/movie_providers.dart';
import 'package:tmdb/features/movies/presentation/widgets/movie_card.dart';
import 'package:tmdb/features/people/presentation/pages/people_page.dart';

class TopRatedMoviesPage extends ConsumerStatefulWidget {
  const TopRatedMoviesPage({super.key});

  @override
  ConsumerState<TopRatedMoviesPage> createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends ConsumerState<TopRatedMoviesPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(paginatedMoviesProvider.notifier).fetchNextPage();
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(paginatedMoviesProvider.notifier).fetchNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(paginatedMoviesProvider);

    return Scaffold(
      backgroundColor: MainColors.background,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const SliverAppBar(
            title: Text('Movies'),
            centerTitle: true,
            floating: true,
            pinned: true,
            backgroundColor: Color(0xff032541),
          ),
          const SliverToBoxAdapter(
            child: BannerWidget(),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _PeoplePageHeader(),
          ),
          SliverPadding(
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
                  if (index < movies.length) {
                    final movie = movies[index];
                    return MovieCardWidget(
                      posterPath: movie.posterPath,
                      title: movie.title,
                      rating: movie.voteAverage,
                    );
                  }
                  return null;
                },
                childCount: movies.length + 1,
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
  double get minExtent => 160.0;
  @override
  double get maxExtent => 160.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return const SizedBox(
      height: 160,
      child: PeoplePage(),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
