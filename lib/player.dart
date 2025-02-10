import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'dart:ui';
import "dart:math";

import 'package:flutter/material.dart';
import 'package:hw3/constants.dart';
import 'package:hw3/projectile.dart';

import 'game/rotate_game.dart';

class Player extends CircleComponent with CollisionCallbacks, HasGameRef<RotateGame>, TapCallbacks {
  double currentAngle = 0 * pi / 180; // 30 degrees opening
  int rotationDirection = 1;
  final double openingAngle = 100 * pi / 180;
  final double rotationSpeed = pi/2; // Radians per second to complete 360 degrees in 2 seconds



  Player()
      : super(
          anchor: Anchor.center,
          position: Vector2(0, 0),
          radius: 200, // Medium size circle
          paint: Paint()
            ..color = const Color.fromARGB(200, 0, 0, 0)
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

      
        // Calculate the start and end angles of the open portion of the arc
        final startAngle = (currentAngle - openingAngle / 2 + 2 * pi) % (2 * pi);
        final endAngle = (currentAngle + openingAngle / 2 + 2 * pi) % (2 * pi);

        // Check if the normalized angle falls within the range of the open portion
        bool isInOpenArea;
        if (startAngle < endAngle) {
            isInOpenArea = normalizedAngle >= startAngle && normalizedAngle <= endAngle;
        } else {
            // Handle the case where the open portion wraps around 0
            isInOpenArea = normalizedAngle >= startAngle || normalizedAngle <= endAngle;
        }

        if (isInOpenArea) {
            print('Hit in the open area');

        other.beenEaten(this);

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
    final startAngle = currentAngle - openingAngle / 2;
    final sweepAngle = 2 * pi - openingAngle;
    path.addArc(rect, startAngle, sweepAngle);

    // Draw the path
    canvas.drawPath(path, paint);

    // Restore the canvas to its original state
    canvas.restore();
  }


  @override
  void update(double dt) {
    super.update(dt);


    // Increment currentAngle based on the rotation speed and elapsed time
    currentAngle += rotationDirection * rotationSpeed * dt;

    // Ensure currentAngle stays within the range [0, 2*pi]
    if (currentAngle >= 2 * pi) {
      currentAngle -= 2 * pi;
    }

    position = Vector2.zero();

  }

    bool containsLocalPoint(Vector2 point) => true;

    @override
  bool onTapDown(TapDownEvent event) {
    final screenSize = gameRef.size;
    final tapPosition = event.canvasPosition;
    print( tapPosition );

    if (tapPosition.x > screenSize.x / 2) {
      // Right side of the screen tapped
      rotationDirection = 1;
    } else {
      // Left side of the screen tapped
      rotationDirection = -1;
    }

    return true;
  }


}