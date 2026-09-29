import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/interactives/interactive_area.dart';
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
      ..sprite = await loadSprite("map/map.png")
      ..size = size;
    add(background!);

    final blue = InteractiveArea(
      relativeX: 0.07761437908496732026143790849673,
      relativeY: 0.42524354087251164760694620923338,
      relativeWidth: 0.41258169934640522875816993464052,
      relativeHeight: 0.22321050402371876323591698432867,
      onTapAction: () {
        changeMainScreen(2);
        if(game.buildContext == null) return;
        Navigator.of(game.buildContext!).pop(); 
      },
    );
    add(blue);
    final greenShop = GameState.instance.userInfo.shopManager.getShop('Green');
    final green = InteractiveArea(
      relativeX: greenShop.relativeX,
      relativeY: greenShop.relativeY,
      relativeWidth: greenShop.relativeWidth,
      relativeHeight: greenShop.relativeHeight,
      onTapAction: () {
        GameState.instance.userInfo.shopManager.currentShop = greenShop;
        changeScreen(0);
      },
    );
    add(green);
    final purpleShop = GameState.instance.userInfo.shopManager.getShop('Purple');
    final purple = InteractiveArea(
      relativeX: purpleShop.relativeX,
      relativeY: purpleShop.relativeY,
      relativeWidth: purpleShop.relativeWidth,
      relativeHeight: purpleShop.relativeHeight,
      onTapAction: () {
        GameState.instance.userInfo.shopManager.currentShop = purpleShop;
        changeScreen(0);
      },
    );
    add(purple);
    final greenMark = InteractiveSprite(
      relativeX: 0.71323529411764705882352941176471,
      relativeY: 0.33587462939432443879711986446421,
      relativeWidth: 0.35,
      relativeHeight: 0.125,
      onTapAction: () {
        GameState.instance.userInfo.shopManager.currentShop = greenShop;
        changeScreen(0);
      },
      assetPath: 'map/shop1_mark.png',
    );
    add(greenMark);
    final fishMark = InteractiveSprite(
      relativeX: 0.69934640522875816993464052287582,
      relativeY: 0.66285472257518000847098686997035,
      relativeWidth: 0.35,
      relativeHeight: 0.125,
      onTapAction: () {
        GameState.instance.userInfo.shopManager.currentShop = greenShop;
        changeScreen(0);
      },
      assetPath: 'map/shop2_mark.png',
    );
    add(fishMark);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    background?.size = size;
  }
}