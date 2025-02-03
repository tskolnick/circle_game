import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hw3/constants.dart';

class Player extends CircleComponent with CollisionCallbacks{
  Player()
      : super(
          anchor: Anchor.center,
          position: Vector2(0, 0),
          radius: 200, // Medium size circle
          paint: Paint()..color = const Color.fromARGB(255, 32, 79, 173),
              ){
                //priority = 10;
              } 

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position = Vector2.zero();

  }


}