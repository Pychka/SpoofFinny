import 'package:flame/components.dart';
import 'package:spoof_finny/models/player.dart';

class PlayerFactory {
  final Map<String, Player> _factories = {};
  PlayerFactory._internal();

  List<Player> get getPlayers => List.unmodifiable(_factories.values); 

  static final PlayerFactory instance = PlayerFactory._internal();

  Player get(String name){
    final player = _factories[name];

    if (player == null) {
      throw Exception("Not found factory by key: $name");
    }

    return player.createNew;
  }

  void register(Player player) =>
    _factories[player.name] = player;

  void init(){
    register(
      Player(
        countFrames: 8,
        textureSize: Vector2(128, 128),
        assetsFolder: 'kitty/',
        stageFolders: ['child/', 'teen/', 'adult/'],
        name: 'kitty'
      )
    );
  }
}