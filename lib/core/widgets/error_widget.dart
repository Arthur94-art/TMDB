import 'package:flutter/material.dart';
import 'package:tmdb/core/styles/main_colors.dart';

class ErrorPage extends StatelessWidget {
  final String _text;
  final VoidCallback _onRefresh;
  const ErrorPage(
      {super.key, required String text, required VoidCallback onRefresh})
      : _onRefresh = onRefresh,
        _text = text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning,
              size: 100,
              color: MainColors.ratingColor,
            ),
            Text(
              _text,
              style: const TextStyle(
                color: MainColors.errorColor,
                fontSize: 20,
              ),
            ),
            IconButton(
              onPressed: _onRefresh,
              icon: const Icon(
                Icons.refresh,
                size: 50,
                color: MainColors.cardColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
