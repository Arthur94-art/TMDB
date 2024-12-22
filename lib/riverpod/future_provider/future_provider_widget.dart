import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/riverpod/future_provider/future_providers.dart';

class FutureProviderWidget extends ConsumerWidget {
  const FutureProviderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(futureProvider);
    return Scaffold(
      body: Center(
        child: asyncValue.when(
          data: (d) {
            return Text(d);
          },
          error: (e, stack) => Text(e.toString()),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
