import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/interactives/interactive_sprite.dart';

class MapScreen extends FlameGame with HasGameReference {
  MapScreen({required this.changeScreen, required this.changeMainScreen});
  SpriteComponent? background;
  final Function(int) changeScreen;
  final Function(int) changeMainScreen;
  
  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    background = SpriteComponent()
      ..sprite = await loadSprite("map/test_map.png")
      ..size = size;
    add(background!);

    final blue = InteractiveSprite(
      relativeX: 0,
      relativeY: 0.3425,
      relativeWidth: 0.3625,
      relativeHeight: 0.3125,
      onTapAction: () {
        changeMainScreen(2);
        if(game.buildContext == null) return;
        Navigator.of(game.buildContext!).pop(); 
      },
      assetPath: 'map/test_blue_house.png'
    );
    add(blue);
    final greenShop = GameState.instance.userInfo.shopManager.getShop('Green');
    final green = InteractiveSprite(
      relativeX: greenShop.relativeX,
      relativeY: greenShop.relativeY,
      relativeWidth: greenShop.relativeWidth,
      relativeHeight: greenShop.relativeHeight,
      onTapAction: () {
        GameState.instance.userInfo.shopManager.currentShop = greenShop;
        changeScreen(0);
      },
      assetPath: greenShop.assetPath
    );
    add(green);
    final purpleShop = GameState.instance.userInfo.shopManager.getShop('Purple');
    final purple = InteractiveSprite(
      relativeX: purpleShop.relativeX,
      relativeY: purpleShop.relativeY,
      relativeWidth: purpleShop.relativeWidth,
      relativeHeight: purpleShop.relativeHeight,
      onTapAction: () {
        GameState.instance.userInfo.shopManager.currentShop = purpleShop;
        changeScreen(0);
      },
      assetPath: purpleShop.assetPath
    );
    add(purple);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    background?.size = size;
  }
}