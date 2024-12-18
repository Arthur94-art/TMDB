import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/core/styles/main_colors.dart';
import 'package:tmdb/core/styles/text_styles.dart';
import 'package:tmdb/core/widgets/banner.dart';
import 'package:tmdb/core/widgets/error_widget.dart';
import 'package:tmdb/core/widgets/loader.dart';
import 'package:tmdb/features/movies/domain/entities/movie_entity.dart';
import 'package:tmdb/features/movies/presentation/provider/movie_providers.dart';
import 'package:tmdb/features/movies/presentation/widgets/movie_card.dart';
import 'package:tmdb/features/shared/presentation/widgets/people_page_header.dart';

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

  int _childCount(AsyncValue<List<MovieEntity>> moviesState) {
    return (moviesState.value?.length ?? 0) +
        (ref.watch(paginatedMoviesProvider.notifier).isLoadingMore ? 1 : 0);
  }

  @override
  Widget build(BuildContext context) {
    final moviesState = ref.watch(paginatedMoviesProvider);

    return Scaffold(
      backgroundColor: MainColors.background,
      body: moviesState.when(
        data: (movies) => CustomScrollView(
          controller: _scrollController,
          slivers: [
            const SliverAppBar(
              title: Text(
                'Movies',
                style: CustomTextStyles.textStyle16,
              ),
              centerTitle: true,
              floating: true,
              pinned: true,
              backgroundColor: MainColors.cardColor,
            ),
            const SliverToBoxAdapter(
              child: BannerWidget(),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: PeoplePageHeader(),
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
                    final movies = moviesState.value ?? [];
                    if (index == movies.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final movie = movies[index];
                    return MovieCardWidget(
                      posterPath: movie.posterPath,
                      title: movie.title,
                      rating: movie.voteAverage,
                    );
                  },
                  childCount: _childCount(moviesState),
                ),
              ),
            )
          ],
        ),
        loading: () => const CustomLoader(),
        error: (e, stackTrace) => Center(
          child: ErrorPage(
            text: '$e',
            onRefresh: () {
              ref.refresh(paginatedMoviesProvider.notifier).fetchNextPage();
            },
          ),
        ),
      ),
    );
  }
}
