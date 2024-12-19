import 'package:flutter/material.dart';
import 'package:tmdb/core/styles/main_colors.dart';

class MovieErrorWidget extends StatelessWidget {
  final Object _error;
  final VoidCallback _onRefresh;
  const MovieErrorWidget({
    super.key,
    required Object error,
    required VoidCallback onRefresh,
  })  : _error = error,
        _onRefresh = onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.warning,
          size: 50,
          color: MainColors.ratingColor,
        ),
        Text(
          '$_error',
          style: const TextStyle(
            color: MainColors.errorColor,
            fontSize: 20,
          ),
        ),
        IconButton(
          onPressed: _onRefresh,
          icon: const Icon(
            Icons.refresh,
            size: 40,
            color: MainColors.cardColor,
          ),
        )
      ],
    );
  }
}
