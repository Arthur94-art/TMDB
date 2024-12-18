import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tmdb/core/api/api_paths.dart';
import 'package:tmdb/core/styles/main_colors.dart';
import 'package:tmdb/core/styles/text_styles.dart';
import 'package:tmdb/features/people/domain/entities/people_entity.dart';

class PeopleCard extends StatelessWidget {
  final PeopleEntity person;
  final bool isSelected;

  const PeopleCard({super.key, required this.person, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: MainColors.cardColor,
          border: isSelected
              ? Border.all(color: MainColors.cardColor, width: 1.5)
              : null,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: '${ApiPaths.posterPath}${person.image}',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: MainColors.c8C8C8,
                  highlightColor: MainColors.f0f0f0,
                  child: Container(
                    color: MainColors.c8C8C8,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.person,
                  size: 100,
                  color: MainColors.grey808080,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                person.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyles.textStyle12,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: MainColors.ratingColor, size: 8),
                const SizedBox(width: 4),
                Text(
                  person.popularity.toStringAsFixed(1),
                  style: CustomTextStyles.textStyle10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
