import 'package:flutter/material.dart';
import 'package:tmdb/core/styles/main_colors.dart';

class PeoplePage extends StatelessWidget {
  const PeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.background,
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Row(
            children: [
              for (var i = 0; i < 10; i++)
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.greenAccent,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
