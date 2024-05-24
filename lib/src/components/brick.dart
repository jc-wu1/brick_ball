import 'package:brick_ball/src/brick_ball.dart';
import 'package:brick_ball/src/config/config.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'components.dart';

class Brick extends RectangleComponent
    with CollisionCallbacks, HasGameReference<BrickBall> {
  Brick({required super.position, required Color color})
      : super(
          size: Vector2(
            brickWidth,
            brickHeight,
          ),
          anchor: Anchor.center,
          paint: Paint()
            ..color = color
            ..style = PaintingStyle.fill,
          children: [
            RectangleHitbox(),
          ],
        );

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    removeFromParent();
    game.score.value++;

    if (game.world.children.query<Brick>().length == 1) {
      game.gameState = GameState.won;
      game.world.removeAll(game.world.children.query<Ball>());
      game.world.removeAll(game.world.children.query<Board>());
    }
  }
}
