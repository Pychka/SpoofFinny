import 'dart:async';
import 'package:flame/components.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/pet_sprites.dart';

enum PlayerState { normal, sad, tired, happy  }

class Player extends SpriteAnimationGroupComponent<PlayerState> with HasGameReference{
  final int countFrames;
  final Vector2 textureSize;
  final double moveSpeed = 32.0;
  String get assetsFolder => currentStage.path;
  final List<PetSprites> sprites;
  final String name;
  String get preview => '${assetsFolder}preview.png';

  Player({
    required this.countFrames,
    required this.textureSize,
    required this.sprites,
    required this.name
    }) : super(size: Vector2.all(256.0), priority: 10);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final petSprite = currentStage;
    final spriteSize = Vector2(petSprite.width.toDouble(), petSprite.height.toDouble());

    final normalSprite = await game.images.load("player/${assetsFolder}_normal.png");
    final sadSprite = await game.images.load("player/${assetsFolder}_sad.png");
    final tiredSprite = await game.images.load("player/${assetsFolder}_tired.png");
    final happySprite = await game.images.load("player/${assetsFolder}_happy.png");

    final normalAnimation = SpriteAnimation.fromFrameData(
      normalSprite,
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 1,
        textureSize: spriteSize,
      )
    );

    final sadAnimation = SpriteAnimation.fromFrameData(
      sadSprite,
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 1,
        textureSize: spriteSize,
      )
    );

    final tiredAnimation = SpriteAnimation.fromFrameData(
      tiredSprite,
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 1,
        textureSize: spriteSize,
      )
    );

    final happyAnimation = SpriteAnimation.fromFrameData(
      happySprite,
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 1,
        textureSize: spriteSize,
      )
    );
    
    animations = {
      PlayerState.normal: normalAnimation,
      PlayerState.sad: sadAnimation,
      PlayerState.tired: tiredAnimation,
      PlayerState.happy: happyAnimation,
    };
    
    changeState();
    position = Vector2(game.size.x / 2, game.size.y - game.size.y / 4);
    anchor = Anchor.center;
  }

  PetSprites get currentStage{
    final level = GameState.instance.userInfo.experienceSystem.currentLevel;
    return sprites[level <= 12 ? 0 : level <= 18 ? 1 : 2];
  }

  Player get createNew => Player(name: name, countFrames: countFrames, textureSize: textureSize, sprites: sprites);

  void changeState() => current = GameState.instance.userInfo.statManager.currentState;
}