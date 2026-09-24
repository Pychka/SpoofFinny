
import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/interactives/interactive_area.dart';

class HomeScreen extends FlameGame with HasGameReference {
  HomeScreen({required this.changeScreen});

  final Function(int) changeScreen;
  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Wait assets :)
    final background = SpriteComponent()
      ..sprite = await loadSprite("hallway/background.png")
      ..size = size;
    add(background);

    final player = GameState.instance.userInfo.newPlayer;

    add(player);    

    final goKitchen = InteractiveArea(
      onTapAction: () {
        changeScreen(2);
      },
      relativeHeight: 0.5,
      relativeWidth: 0.125,
      relativeX: 0.06,
      relativeY: 0.15,
    );
    add(goKitchen);
  }
}