import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb/riverpod/stream_provider/stream_providers.dart';

class StreamProviderWidget extends ConsumerStatefulWidget {
  const StreamProviderWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<StreamProviderWidget> {
  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(streamProvider);
    return Scaffold(
      body: Center(
        child: asyncValue.when(
          data: (d) {
            return Text('$d');
          },
          error: (e, stack) => Text(e.toString()),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
