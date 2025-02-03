import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hw3/constants.dart';
import 'package:hw3/game/rotate_game.dart';
import 'package:hw3/player.dart';

class Projectile extends CircleComponent with CollisionCallbacks, HasGameRef<RotateGame>{
  Projectile() : super(
    anchor: Anchor.center,
    position: Vector2(100, -300),
    radius: 50,
    paint: Paint()..color = const Color(0xFFFFFFFF),
  ){
    priority = 10;
    } 

  Vector2 velocity =  Vector2(-2, 5) * 20; // (Vector2.random() - Vector2.random()) * 5;
  bool collided = false;
  Player? object_colided_with = null;
  CircleHitbox hitbox = CircleHitbox()       
        ..debugColor = Colors.red
        ..debugMode = true;

  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    hitbox.position = Vector2(100, -200);

 

    add( hitbox );
  }



   // @override
  void onCollision(Set<Vector2> points, PositionComponent other) {


    if (other is Player) {
      object_colided_with = other;
    } 
  }




  @override
  void update(double dt) {
    if (object_colided_with != null) {

      print( 'collided' );
      Vector2 normal = (position - object_colided_with!.position).normalized();

      // Place the projectile on the edge of the player's circle
      position = object_colided_with!.position + normal * (object_colided_with!.radius + radius );


      print( velocity );
      // Reflect the velocity vector based on the tangent
      velocity = velocity.reflected(normal);
      print( "reflected  $velocity" );
 
      object_colided_with = null;
      //velocity = Vector2(0, 0);
    } else if (position.x - radius < -gameWidth / 2) {
      position.x = -gameWidth / 2 + radius;
      velocity.x = -velocity.x;
    } else if (position.x + radius > gameWidth / 2) {
      position.x = gameWidth / 2 - radius;
      velocity.x = -velocity.x;
    } else if (position.y - radius < -gameHeight / 2) {
      position.y = -gameHeight / 2 + radius;
      velocity.y = -velocity.y;
    } else if (position.y + radius > gameHeight / 2) {
      position.y = gameHeight / 2 - radius;
      velocity.y = -velocity.y;
    } else {
      // If not collided with anything then put the porjectile 
      // where the hitbox was, and move the hitbox to new spot.
      position += hitbox.position;

    }

    hitbox.position = velocity * dt;
    super.update(dt);
  }
}



