import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/interactives/interactive_area.dart';

class LivingroomScreen extends FlameGame with HasGameReference {
  LivingroomScreen({required this.changeScreen});

  final Function(int) changeScreen;
  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Wait assets :)
    final background = SpriteComponent()
      ..sprite = await loadSprite("livingroom/background.png")
      ..size = size;
    add(background);

    final player = GameState.instance.userInfo.newPlayer;

    add(player);    

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