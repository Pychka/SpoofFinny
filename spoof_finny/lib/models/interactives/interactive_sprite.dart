import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class InteractiveSprite extends SpriteComponent with TapCallbacks, HasGameReference {
  final VoidCallback onTapAction;
  bool _isPressed = false;
  final String assetPath;
  final double _relativeX;
  final double _relativeY;
  final double _relativeWidth;
  final double _relativeHeight;

  InteractiveSprite({
    required this._relativeX,
    required this._relativeY,
    required this._relativeWidth,
    required this._relativeHeight,
    required this.onTapAction,
    required this.assetPath,
    super.anchor,
  });

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = Sprite(await game.images.load(assetPath));
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    _isPressed = true; 
    onTapAction();
  }
  
  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    _isPressed = false; 
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    super.onTapCancel(event);
    _isPressed = false; 
  }

  @override void render(Canvas canvas) {
    if (_isPressed) {
      paint.colorFilter = ColorFilter.mode(
        Color.fromARGB(40, 255, 255, 255),
        BlendMode.srcATop,
      );
    } else {
      paint.colorFilter = null;
    }
    super.render(canvas);
  }

  

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    size = Vector2(
      size.x * _relativeWidth,
      size.y * _relativeHeight,
    );

    position = Vector2(
      size.x * _relativeX,
      size.y * _relativeY,
    );
  }
}