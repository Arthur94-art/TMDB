import 'package:flutter_riverpod/flutter_riverpod.dart';

final futureProvider = FutureProvider<String>((ref) async {
  await Future.delayed(const Duration(seconds: 2));
  return 'Future Provider';
});
