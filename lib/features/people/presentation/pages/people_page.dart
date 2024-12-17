import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/core/styles/main_colors.dart';
import 'package:tmdb/features/people/domain/entities/people_entity.dart';
import 'package:tmdb/features/people/presentation/provider/people_providers.dart';

class PeoplePage extends ConsumerStatefulWidget {
  const PeoplePage({super.key});

  @override
  ConsumerState<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends ConsumerState<PeoplePage> {
  final ScrollController _scrollController = ScrollController();

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
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: peopleList.length,
                itemBuilder: (context, index) {
                  final person = peopleList[index];
                  return _PeopleCard(person: person);
                },
              ),
      ),
    );
  }
}

class _PeopleCard extends StatelessWidget {
  final PeopleEntity person;

  const _PeopleCard({required this.person});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              'https://image.tmdb.org/t/p/w200${person.image}',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.person, size: 100, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            person.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
          ),
          Text(
            'Popularity: ${person.popularity}',
            style: const TextStyle(fontSize: 10.0, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
