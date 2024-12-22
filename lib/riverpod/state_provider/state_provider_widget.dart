import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/riverpod/state_provider/state_providers.dart';

class StateProviderWidget extends ConsumerWidget {
  const StateProviderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(stateProvider);

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$count'),
            ElevatedButton(
              onPressed: () {
                ref.read(stateProvider.notifier).state++;
              },
              child: const Text('+'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(stateProvider.notifier).state--;
              },
              child: const Text('-'),
            ),
          ],
        ),
      ),
    );
  }
}
