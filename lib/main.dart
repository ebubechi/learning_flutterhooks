import 'dart:async';
import 'dart:math';
// import 'dart:developer';
// import 'dart:math';

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

enum Action {
  rotateRight,
  rotateLeft,
  moreVisible,
  lessVisible,
}

@immutable
class State {
  final double rotationDeg;
  final double alpha;

  const State({
    required this.rotationDeg,
    required this.alpha,
  });

  const State.zero()
      : rotationDeg = 0.0,
        alpha = 1.0;

  State rotateRight() => State(
        rotationDeg: rotationDeg + 10.0,
        alpha: alpha,
      );

  State rotateLeft() => State(
        rotationDeg: rotationDeg - 10.0,
        alpha: alpha,
      );

  State increaseAlpha() => State(
        rotationDeg: rotationDeg,
        alpha: min(alpha + 0.1, 1.0),
      );

  State decreaseAlpha() => State(
        rotationDeg: rotationDeg,
        alpha: max(alpha - 0.1, 0.0),
      );
}

State reducer(State oldState, Action? action) {
  switch (action) {
    case Action.rotateLeft:
      return oldState.rotateLeft();
    case Action.rotateRight:
      return oldState.rotateRight();
    case Action.moreVisible:
      return oldState.increaseAlpha();
    case Action.lessVisible:
      return oldState.decreaseAlpha();
    case null:
      return oldState;
  }
}

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = useReducer<State, Action?>(
      reducer,
      initialState: const State.zero(),
      initialAction: null,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hey There!'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              RotateLeftButton(store: store),
              RotateRightButton(store: store),
              DecreaseAlphaButton(store: store),
              IncreaseAlphaButton(store: store),
            ],
          ),
          const SizedBox(
            height: 120.0,
          ),
          Opacity(
            opacity: store.state.alpha,
            child: RotationTransition(
                turns: AlwaysStoppedAnimation(
                  store.state.rotationDeg / 360.0,
                ),
                child: Image.network(uri)),
          ),
        ],
      ),
    );
  }
}

class IncreaseAlphaButton extends StatelessWidget {
  const IncreaseAlphaButton({
    super.key,
    required this.store,
  });

  final Store<State, Action?> store;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
          onPressed: () {
            store.dispatch(Action.moreVisible);
          },
          child: const Text('Increase Alpha')),
    );
  }
}

class DecreaseAlphaButton extends StatelessWidget {
  const DecreaseAlphaButton({
    super.key,
    required this.store,
  });

  final Store<State, Action?> store;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
          onPressed: () {
            store.dispatch(Action.lessVisible);
          },
          child: const Text('Decrease Alpha')),
    );
  }
}

class RotateRightButton extends StatelessWidget {
  const RotateRightButton({
    super.key,
    required this.store,
  });

  final Store<State, Action?> store;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
          onPressed: () {
            store.dispatch(Action.rotateRight);
          },
          child: const Text('Rotate Right')),
    );
  }
}

class RotateLeftButton extends StatelessWidget {
  const RotateLeftButton({
    super.key,
    required this.store,
  });

  final Store<State, Action?> store;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
          onPressed: () {
            store.dispatch(Action.rotateLeft);
          },
          child: const Text('Rotate Left')),
    );
  }
}
