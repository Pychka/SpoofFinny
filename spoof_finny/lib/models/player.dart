import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

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
    }) : super(size: Vector2.all(120.0));

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Wait sprites :)
    final idleSprite = await game.images.load("player.png");

    final walkSprite = await game.images.load("player.png");

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
    
    current = PlayerState.idle; // Начинаем с ходьбы
    position = Vector2(100, game.size.y / 2);
    anchor = Anchor.center;
  }
}