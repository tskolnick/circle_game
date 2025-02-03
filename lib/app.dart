import 'package:flutter/material.dart';
import 'package:hw3/constants.dart';
import 'game/rotate_game.dart';
import 'package:flame/game.dart';

class GameApp extends StatefulWidget {
  @override
  _GameAppState createState() => _GameAppState(); 
}

class _GameAppState extends State<GameApp> {
  late final RotateGame game;

  @override
  void initState() {
    super.initState();
    game = RotateGame();
  } 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: FittedBox(
              alignment: Alignment.center,
              child: SizedBox(
                width: gameWidth,
                height: gameHeight,
                child: GameWidget(game: game),
              ),
            ),
          ),
        ),
      ),
    );
  }
}