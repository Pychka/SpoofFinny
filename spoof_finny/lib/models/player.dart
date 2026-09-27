import 'dart:async';
import 'package:flame/components.dart';
import 'package:spoof_finny/models/game_state.dart';

enum PlayerState { idle, walk, }

class Player extends SpriteAnimationGroupComponent<PlayerState> with HasGameReference{
  final int countFrames;
  final Vector2 textureSize;
  final double moveSpeed = 32.0;
  final String assetsFolder;
  final List<String> stageFolders;
  final String name;
  String get preview => '${assetsFolder}preview.png';

  Player({
    required this.countFrames,
    required this.textureSize,
    required this.assetsFolder,
    required this.stageFolders,
    required this.name
    }) : super(size: Vector2.all(256.0), priority: 10);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Wait sprites :)
    final idleSprite = await game.images.load("player/$assetsFolder${stageFolder}idle.png");
    final walkSprite = await game.images.load("player/$assetsFolder${stageFolder}run.png");

    final idleAnimation = SpriteAnimation.fromFrameData(
      idleSprite,
      SpriteAnimationData.sequenced(
        amount: countFrames,
        stepTime: 1.0 / countFrames,
        textureSize: textureSize,
      )
    );

    final walkAnimation = SpriteAnimation.fromFrameData(
      walkSprite,
      SpriteAnimationData.sequenced(
        amount: countFrames,
        stepTime: 1.0 / countFrames,
        textureSize: textureSize,
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

  String get stageFolder {
    final level = GameState.instance.userInfo.experienceSystem.currentLevel;
    return stageFolders[level >= 18 ? 2 : level >= 12 ? 1 : 0];
  }

  Player get createNew => Player(name: name, countFrames: countFrames, textureSize: textureSize, assetsFolder: assetsFolder, stageFolders: stageFolders);
}