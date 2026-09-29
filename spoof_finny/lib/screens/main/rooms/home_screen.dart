
import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/interactives/interactive_area.dart';

class HomeScreen extends FlameGame with HasGameReference {
  HomeScreen({required this.changeScreen});
  SpriteComponent? background;
  final Function(int) changeScreen;
  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Wait assets :)
    background = SpriteComponent()
      ..sprite = await loadSprite("hallway/background.png")
      ..size = size;
    add(background!);

    final player = GameState.instance.userInfo.newPlayer;

    add(player);    

    final goBathroom = InteractiveArea(
      onTapAction: () {
        changeScreen(3);
      },
      relativeHeight: 0.5,
      relativeWidth: 0.125,
      relativeX: 0.06,
      relativeY: 0.15,
    ); 
    add(goBathroom);

    final goKitchen = InteractiveArea(
      onTapAction: () {
        changeScreen(1);
      },
      relativeHeight: 0.2936197916666667,
      relativeWidth: 0.2783203125,
      relativeX: 0.33203125,
      relativeY: 0.2278645833333333,
    );
    add(goKitchen);

    final goBedroom = InteractiveArea(
      onTapAction: () {
        changeScreen(4);
      },
      relativeHeight: 0.6484375,
      relativeWidth: 0.16796875,
      relativeX: 0.7763671875,
      relativeY: 0,
    );
    add(goBedroom);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    background?.size = size;
  }
}