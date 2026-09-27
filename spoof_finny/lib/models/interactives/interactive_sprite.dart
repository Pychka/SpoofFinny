import 'dart:async';
import 'dart:ui' as ui;
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
  ui.Image? _image;
  List<int>? _pixelData;

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
    final image = await game.images.load(assetPath);
    _image = image;
    sprite = Sprite(image);

    final byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    if (byteData != null) {
      _pixelData = byteData.buffer.asUint8List();
    }
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

  @override
  bool containsLocalPoint(Vector2 point) {
    if (!super.containsLocalPoint(point) || _image == null || _pixelData == null) {
      return false;
    }

    final int pixelX = ((point.x / size.x) * _image!.width).floor().clamp(0, _image!.width - 1);
    final int pixelY = ((point.y / size.y) * _image!.height).floor().clamp(0, _image!.height - 1);

    final int pixelIndex = (pixelY * _image!.width + pixelX) * 4;
    final int alpha = _pixelData![pixelIndex + 3];

    return alpha > 10;
  }

  @override void render(Canvas canvas) {
    if (_isPressed) {
      paint.colorFilter = ColorFilter.mode(
        Color.fromARGB(80, 255, 255, 255),
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