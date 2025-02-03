import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hw3/game/rotate_world.dart';
import "../projectile.dart";
import 'package:flame/game.dart';
import 'package:flame/components.dart'; // Import the necessary package

class RotateGame extends FlameGame with SingleGameInstance, HasCollisionDetection {
  
  RotateGame() : super(
  world: RotateWorld(),
  );

  @override
  Future<void> onLoad() async {
  await super.onLoad();
  add(ScreenHitbox()); // Add the ScreenHitbox component
  }

  @override
  Color backgroundColor() {
  return Colors.green;
  }
}
