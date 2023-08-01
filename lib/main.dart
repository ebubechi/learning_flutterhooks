import 'dart:async';
import 'dart:developer';
import 'dart:math';

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

const uri =
    'https://www.thewowstyle.com/wp-content/uploads/2015/01/images-of-nature-4.jpg';
const imageHeight = 300.0;

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    late final StreamController<double> controller;
    controller = useStreamController<double>(onListen: () {
      controller.sink.add(0.0);
    });
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hey There!'),
        ),
        body: StreamBuilder<double>(
            stream: controller.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                final rotation = snapshot.data ?? 0.0;
                return GestureDetector(
                  onTap: () {
                    controller.sink.add(rotation + 10.0);
                  },
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(rotation / 7),
                    child: Center(
                      child: Image.network(uri),
                    ),
                  ),
                );
              }
            }));
  }
}
