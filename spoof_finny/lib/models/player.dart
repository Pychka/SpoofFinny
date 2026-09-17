import 'dart:async';
import 'package:flame/components.dart';

enum PlayerState { idle, walk, }

class Player extends SpriteAnimationGroupComponent<PlayerState> with HasGameReference{
  final int countFrames;
  final double textureSize;
  final double moveSpeed = 32.0;
  final String assetsFolder;

  Player({
    required this.countFrames,
    required this.textureSize,
    required this.assetsFolder
    }) : super(size: Vector2.all(256.0), priority: 10);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Wait sprites :)
    final idleSprite = await game.images.load("${assetsFolder}idle.png");

    final walkSprite = await game.images.load("${assetsFolder}run.png");

    final idleAnimation = SpriteAnimation.fromFrameData(
      idleSprite,
      SpriteAnimationData.sequenced(
        amount: countFrames,
        stepTime: 1.0 / countFrames,
        textureSize: Vector2.all(textureSize),
      )
    );

    final walkAnimation = SpriteAnimation.fromFrameData(
      walkSprite,
      SpriteAnimationData.sequenced(
        amount: countFrames,
        stepTime: 1.0 / countFrames,
        textureSize: Vector2.all(textureSize),
      )
    );
    
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.walk: walkAnimation,
    };
    
    current = PlayerState.idle;
    position = Vector2(game.size.x / 2, game.size.y - game.size.y / 4);
    anchor = Anchor.center;
  }
}