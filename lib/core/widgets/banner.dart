import 'package:flutter/material.dart';
import 'package:tmdb/gen/assets.gen.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.asset(
            const $AssetsImagesGen().banner.path,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
