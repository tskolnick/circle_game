import 'package:flame/components.dart';
import 'package:hw3/game/rotate_game.dart';
import 'package:hw3/player.dart';
import 'package:hw3/projectile.dart';

class RotateWorld extends World with HasGameRef<RotateGame>, HasCollisionDetection {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    final projectile = Projectile();
    final player = Player();


      await add(player);

    for (int i = 0; i < 1; i++) {
      await add(Projectile());
    }

  }
}
