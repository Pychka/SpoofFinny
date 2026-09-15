
import 'dart:async';
import 'package:flame/game.dart';
import 'package:spoof_finny/models/player.dart';

class HomeScreen extends FlameGame {
  
  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Wait assets :)
    // final background = SpriteComponent()
    //   ..sprite = await loadSprite("assets/home/background.png")
    //   ..size = size;
    // add(background);

    final player = Player(
      assetsFolder: '',
      countFrames: 8,
      textureSize: 120
    );

    add(player);
  }
}