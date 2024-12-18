import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/core/styles/main_colors.dart';
import 'package:tmdb/core/widgets/loader.dart';
import 'package:tmdb/features/people/presentation/provider/people_providers.dart';
import 'package:tmdb/features/people/presentation/widgets/people_card.dart';
import 'package:tmdb/features/people/presentation/widgets/people_error_card.dart';

class PeopleList extends ConsumerStatefulWidget {
  const PeopleList({super.key});

  @override
  ConsumerState<PeopleList> createState() => _PeoplePageState();
}

class _PeoplePageState extends ConsumerState<PeopleList> {
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
      duration: const Duration(milliseconds: 200),
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
    final peopleState = ref.watch(paginatedPeopleProvider);

    return Scaffold(
      backgroundColor: MainColors.background,
      body: peopleState.when(
        data: (peopleList) => SizedBox(
          height: 160,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: peopleList.length,
            itemBuilder: (context, index) {
              final person = peopleList[index];
              final isSelected = index == _selectedIndex;

              return GestureDetector(
                onTap: () => _onCardTap(index),
                child: PeopleCard(
                  key: ValueKey(person.id),
                  person: person,
                  isSelected: isSelected,
                ),
              );
            },
          ),
        ),
        loading: () => const CustomLoader(),
        error: (e, stackTrace) => Center(
          child: ErrorPeopleCard(message: '$e'),
        ),
      ),
    );
  }
}
