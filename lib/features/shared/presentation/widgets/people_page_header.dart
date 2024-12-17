import 'package:flutter/material.dart';
import 'package:tmdb/features/people/presentation/pages/people_page.dart';

class PeoplePageHeader extends SliverPersistentHeaderDelegate {
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
