import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

const uri =
    'https://www.thewowstyle.com/wp-content/uploads/2015/01/images-of-nature-4.jpg';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = useAppLifecycleState();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hey There!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Opacity(
          opacity: state == AppLifecycleState.resumed ? 1.0 : 0.0,
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Colors.black.withAlpha(100),
                spreadRadius: 10,
              )
            ]),
            child: Image.asset('assets/card.png'),
          ),
        ),
      ),
    );
  }
}
