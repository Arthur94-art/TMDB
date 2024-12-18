import 'package:flutter/material.dart';
import 'package:tmdb/features/people/presentation/widgets/people_list.dart';

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
      child: PeopleList(),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
