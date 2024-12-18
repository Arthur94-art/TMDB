import 'package:flutter/material.dart';
import 'package:tmdb/core/styles/main_colors.dart';
import 'package:tmdb/core/styles/text_styles.dart';

class ErrorPeopleCard extends StatelessWidget {
  final String _message;
  const ErrorPeopleCard({super.key, required String message})
      : _message = message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: MainColors.c8C8C8.withOpacity(0.5),
          border: Border.all(color: MainColors.errorColor, width: 1.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: MainColors.cardColor,
                size: 50,
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  _message,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.textStyle12.copyWith(
                    color: MainColors.cardColor,
                  ),
                ),
              ),
              const SizedBox(height: 4.0),
            ],
          ),
        ),
      ),
    );
  }
}
