
import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:spoof_finny/models/interactive_area.dart';
import 'package:spoof_finny/models/player.dart';

class HomeScreen extends FlameGame with HasGameReference {
  
  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Wait assets :)
    final background = SpriteComponent()
      ..sprite = await loadSprite("hallway/background.png")
      ..size = size;
    add(background);

    final player = Player(
      assetsFolder: 'kitty/',
      countFrames: 8,
      textureSize: 128
    );

    add(player);
    
    final table = InteractiveArea(
      position: Vector2(min(game.size.x - game.size.x / 6, game.size.x - 128), game.size.y - game.size.y / 2.5),
      size: Vector2(128, 128),
      assetPath: 'table.png',
      onTapAction: () => {
        print('table is pressed')
      }
    );
    add(table);
  }
}