import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

extension CompactMap<T> on Iterable<T?> {
  Iterable<T> conmpactMap<E>([
    E? Function(T?)? transform,
  ]) =>
      map(transform ?? (e) => e).where((e) => e != null).cast();
}

// void testIt() {
//   final values = [1, 2, null, 3];
//   final nonNullValues = values.conmpactMap();
//   log(nonNullValues.toString());
// }

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.amber,
    ),
    home: const HomePage(),
  ));
}

class CountDown extends ValueNotifier<int> {
  late StreamSubscription sub;
  CountDown({required int from}) : super(from) {
    sub = Stream.periodic(const Duration(seconds: 1), (v) => from - v)
        .takeWhile((value) => value >= 0)
        .listen((value) {
      this.value = value;
    });
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final countDown = useMemoized(() => CountDown(from: 20));
    final notifier = useListenable(countDown);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hey There!'),
        // title: Text(dataTime.data ?? 'Hey There!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Text(
          notifier.value.toString(),
        ),
      ),
    );
  }
}
