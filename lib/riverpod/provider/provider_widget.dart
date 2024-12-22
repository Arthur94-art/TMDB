import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/riverpod/provider/providers.dart';

class ProviderWidget extends ConsumerWidget {
  const ProviderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(providers);
    return Scaffold(
      body: Center(child: Text(value)),
    );
  }
}
