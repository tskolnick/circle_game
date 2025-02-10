import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/experimental.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hw3/constants.dart';
import 'package:hw3/game/rotate_game.dart';
import 'package:hw3/player.dart';

class Projectile extends CircleComponent with CollisionCallbacks, HasGameRef<RotateGame>{

  Vector2 velocity =  (Vector2.random() - Vector2.random()).normalized() * 200;
  bool collided = false;
  Player? object_colided_with = null;
  CircleHitbox hitbox = CircleHitbox()       
       // ..debugColor = Colors.red
        ..debugMode = false;
  bool isBeingEaten = false;

  Projectile() : super(
    anchor: Anchor.center,
    position: Vector2(100, -300),
    radius: 50,
    paint: Paint()..color = const Color(0x99FFFFFF),
  ){
    priority = 10;
    } 
  
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

  void beenEaten(Player player) {
    if (isBeingEaten) {
      return;
    } 
    isBeingEaten = true; // Set the flag to stop usual movement
    print( player.position );

    // Animate the projectile to move to the center of the player
    add(MoveEffect.to(
      player.position,
      EffectController(duration: 1.5, curve: Curves.easeOut),
    ));

    // Fade out the projectile
    add(OpacityEffect.to(
      0.0,
      EffectController(duration: 0.5, startDelay: 1.5, curve: Curves.easeInOut),
    ));

    // Remove the projectile after the fade-out effect
    Future.delayed(Duration(seconds: 3), () {
      removeFromParent();
    });
  }


  @override
  void update(double dt) {
    if ( !isBeingEaten ) {

      
      if (object_colided_with != null) {

        //print( 'collided' );
        Vector2 normal = (position - object_colided_with!.position).normalized();

        // Place the projectile on the edge of the player's circle
        position = object_colided_with!.position + normal * (object_colided_with!.radius + radius );


        // Reflect the velocity vector based on the tangent
        velocity = velocity.reflected(normal);

  
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
    }
    super.update(dt);
  }
}



