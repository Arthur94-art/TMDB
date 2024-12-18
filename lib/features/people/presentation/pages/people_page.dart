import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/core/styles/main_colors.dart';
import 'package:tmdb/core/widgets/loader.dart';
import 'package:tmdb/features/people/presentation/provider/people_providers.dart';
import 'package:tmdb/features/people/presentation/widgets/people_card.dart';

class PeoplePage extends ConsumerStatefulWidget {
  const PeoplePage({super.key});

  @override
  ConsumerState<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends ConsumerState<PeoplePage> {
  final ScrollController _scrollController = ScrollController();
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(paginatedPeopleProvider.notifier).fetchNextPage();
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(paginatedPeopleProvider.notifier).fetchNextPage();
    }
  }

  void _onCardTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    const cardWidth = 116.0;
    final targetOffset = (index * cardWidth) -
        (MediaQuery.of(context).size.width / 2 - cardWidth / 2);

    final currentOffset = _scrollController.offset;
    if ((currentOffset - targetOffset).abs() < 10.0) {
      return;
    }

    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final peopleList = ref.watch(paginatedPeopleProvider);

    return Scaffold(
      backgroundColor: MainColors.background,
      body: SizedBox(
        height: 160,
        child: peopleList.isEmpty
            ? const CustomLoader()
            : ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: peopleList.length,
                itemBuilder: (context, index) {
                  final person = peopleList[index];
                  final isSelected = index == _selectedIndex;

                  return GestureDetector(
                    onTap: () => _onCardTap(index),
                    child: PeopleCard(
                      person: person,
                      isSelected: isSelected,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
