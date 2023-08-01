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
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amber),
    home: const HomePage(),
  ));
}

// Stream<String> getTime() => Stream.periodic(
//       const Duration(seconds: 1),
//       (_) => DateTime.now().toIso8601String(),
//     );

const uri =
    'https://www.thewowstyle.com/wp-content/uploads/2015/01/nature-images..jpg';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    /// * This is caching the api call
    final future = useMemoized(() => NetworkAssetBundle(Uri.parse(uri))
        .load(uri)
        .then((data) => data.buffer.asUint8List())
        .then((data) => Image.memory(data)));

    final snapshot = useFuture(future);
    // final image = useFuture(NetworkAssetBundle(Uri.parse(uri))
    //     .load(uri)
    //     .then((data) => data.buffer.asUint8List())
    //     .then((data) => Image.memory(data)));
    // testIt();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hey There!'),
        // title: Text(dataTime.data ?? 'Hey There!'),
      ),
      body: Column(
          children: [
        snapshot.data,
      ].conmpactMap().toList()
          //   image.hasData ? image.data! : null,
          // ].conmpactMap().toList(),
          ),
    );
  }
}
