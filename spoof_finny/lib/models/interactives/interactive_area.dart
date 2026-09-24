import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class InteractiveArea extends PositionComponent with TapCallbacks, HasGameReference {
  final VoidCallback onTapAction;
  bool _isPressed = false;
  final double _relativeX;
  final double _relativeY;
  final double _relativeWidth;
  final double _relativeHeight;

  InteractiveArea({
    required this._relativeX,
    required this._relativeY,
    required this._relativeWidth,
    required this._relativeHeight,
    required this.onTapAction,
    super.anchor,
  });

  @override
  Future<void> onLoad() async {
    super.onLoad();
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
    canvas.drawRect(
      size.toRect(),
      Paint()..color = Color.fromARGB(_isPressed ? 140 : 0, 255, 255, 255)
    );
    super.render(canvas);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    this.size = Vector2(
      size.x * _relativeWidth,
      size.y * _relativeHeight,
    );

    position = Vector2(
      size.x * _relativeX,
      size.y * _relativeY,
    );
  }
}