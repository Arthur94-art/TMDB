import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/core/styles/main_colors.dart';
import 'package:tmdb/core/styles/text_styles.dart';
import 'package:tmdb/core/widgets/banner.dart';
import 'package:tmdb/features/movies/presentation/provider/movie_providers.dart';
import 'package:tmdb/features/movies/presentation/widgets/movies_list.dart';
import 'package:tmdb/features/people/presentation/widgets/people_page_header.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
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
    return Scaffold(
      backgroundColor: MainColors.background,
      body: CustomScrollView(
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
          MovieList(scrollController: _scrollController),
        ],
      ),
    );
  }
}
