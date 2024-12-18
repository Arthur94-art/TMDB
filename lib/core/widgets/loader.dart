import 'package:flutter/material.dart';
import 'package:tmdb/core/styles/main_colors.dart';

class CustomLoader extends StatelessWidget {
  final double? _size;
  const CustomLoader({super.key, double? size}) : _size = size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: _size ?? 40,
        height: _size ?? 40,
        child: const CircularProgressIndicator(
          color: MainColors.cardColor,
        ),
      ),
    );
  }
}
