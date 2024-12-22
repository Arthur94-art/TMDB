import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/riverpod/state_notifier_provider/s_notifier_provider_widget.dart';

class StateNorifierProviderWidget extends ConsumerWidget {
  const StateNorifierProviderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(stateNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$count'),
            ElevatedButton(
              onPressed: () {
                ref.read(stateNotifierProvider.notifier).decrement();
              },
              child: const Text('+'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(stateNotifierProvider.notifier).increment();
              },
              child: const Text('-'),
            ),
          ],
        ),
      ),
    );
  }
}
