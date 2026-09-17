import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class InteractiveArea extends SpriteComponent with TapCallbacks, HasGameReference {
  final Function() onTapAction;
  bool _isPressed = false;
  final String assetPath;

  InteractiveArea({
    required super.position,
    required super.size,
    required this.assetPath,
    required this.onTapAction,
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
}