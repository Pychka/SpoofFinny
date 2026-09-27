import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/interactives/interactive_area.dart';
import 'package:spoof_finny/screens/additional/fridge_screen.dart';

class KitchenScreen extends FlameGame with HasGameReference {
  KitchenScreen({required this.changeScreen});

  final Function(int) changeScreen;
  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Wait assets :)
    final background = SpriteComponent()
      ..sprite = await loadSprite("kitchen/background.png")
      ..size = size;
    add(background);

    final player = GameState.instance.userInfo.newPlayer;

    add(player);

    final fridge = InteractiveArea(
      onTapAction: () {
        if (game.buildContext != null) {
          showDialog(
            context: game.buildContext!,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return const FridgeScreen();
            },
          );
        }
      },
      relativeHeight: 0.4,
      relativeWidth: 0.125,
      relativeX: 0.06,
      relativeY: 0.2,
    );
    add(fridge);
    final goBack = InteractiveArea(
      onTapAction: () {
        changeScreen(2);
      },
      relativeHeight: 0.2,
      relativeWidth: 0.88,
      relativeX: 0.06,
      relativeY: 0.8,
    );
    add(goBack);
  }
}