import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'dart:ui';
import "dart:math";

import 'package:flutter/material.dart';
import 'package:hw3/constants.dart';
import 'package:hw3/projectile.dart';

class Player extends CircleComponent with CollisionCallbacks{
  final double openingAngle = 30 * pi / 180; // 30 degrees opening
  
  Player()
      : super(
          anchor: Anchor.center,
          position: Vector2(0, 0),
          radius: 200, // Medium size circle
          paint: Paint()
            ..color = const Color.fromARGB(255, 32, 79, 173)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 10, // Set the stroke width
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(CircleHitbox());
  }

   @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points, other);
    if (other is Projectile) {
      final collisionPoint = points.first;
      final angle = (collisionPoint - position).angleToSigned(Vector2(1, 0));

      // Normalize the angle to be between 0 and 2*pi
      final normalizedAngle = (angle + 2 * pi) % (2 * pi);

      // Check if the angle falls within the range of the opening
      if (normalizedAngle < openingAngle || normalizedAngle > 2 * pi - openingAngle) {
        print('Hit in the open area');
      } else {
        print('Hit in the closed area');
      }
    }
  }
  
  @override
  void render(Canvas canvas) {
    // Translate the canvas to the component's position
    canvas.save();
    canvas.translate(size.x / 2, size.y / 2);

    // Create a path for the arc with an opening
    final path = Path();
    final rect = Rect.fromCircle(center: Offset.zero, radius: radius);
    path.addArc(rect, 0.0, 2 * pi - 30 * pi / 180); // 30 degrees opening

    // Draw the path
    canvas.drawPath(path, paint);

    // Restore the canvas to its original state
    canvas.restore();
  }


  @override
  void update(double dt) {
    super.update(dt);

    position = Vector2.zero();

  }


}