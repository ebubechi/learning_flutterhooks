import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amber),
    home: const HomePage(),
  ));
}

Stream<String> getTime() => Stream.periodic(
      const Duration(seconds: 1),
      (_) => DateTime.now().toIso8601String(),
    );

class HomePage extends HookWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final dataTime = useStream(getTime());
    return Scaffold(
      appBar: AppBar(
        title: Text(dataTime.data ?? 'Hey There!'),
      ),
      body: Container(),
    );
  }
}