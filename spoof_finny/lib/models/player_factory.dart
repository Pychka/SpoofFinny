import 'package:flame/components.dart';
import 'package:spoof_finny/models/pet_sprites.dart';
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
        countFrames: 1,
        textureSize: Vector2(128, 128),
        name: 'Зелённый котик',
        sprites: [
          PetSprites(
            width: 548,
            height: 498,
            path: 'kitty/child/green/green_cat'
          ),
          PetSprites(
            width: 680,
            height: 606,
            path: 'kitty/teen/green/green_cat'
          ),
          PetSprites(
            width: 850,
            height: 874,
            path: 'kitty/adult/green/green_cat'
          ),
        ]
      )
    );
    register(
      Player(
        countFrames: 1,
        textureSize: Vector2(128, 128),
        name: 'Серый котик',
        sprites: [
          PetSprites(
            width: 548,
            height: 498,
            path: 'kitty/child/grey/grey_cat'
          ),
          PetSprites(
            width: 680,
            height: 606,
            path: 'kitty/teen/grey/grey_cat'
          ),
          PetSprites(
            width: 850,
            height: 874,
            path: 'kitty/adult/grey/grey_cat'
          ),
        ]
      )
    );
    register(
      Player(
        countFrames: 1,
        textureSize: Vector2(128, 128),
        name: 'Белый котик',
        sprites: [
          PetSprites(
            width: 548,
            height: 498,
            path: 'kitty/child/white/white_cat'
          ),
          PetSprites(
            width: 680,
            height: 606,
            path: 'kitty/teen/white/white_cat'
          ),
          PetSprites(
            width: 850,
            height: 874,
            path: 'kitty/adult/white/white_cat'
          ),
        ]
      )
    );

    register(
      Player(
        countFrames: 1,
        textureSize: Vector2(128, 128),
        name: 'Зефирка',
        sprites: [
          PetSprites(
            width: 544,
            height: 556,
            path: 'dog/child/blond/blond_dog'
          ),
          PetSprites(
            width: 628,
            height: 626,
            path: 'dog/teen/blond/blond_dog'
          ),
          PetSprites(
            width: 728,
            height: 728,
            path: 'dog/adult/blond/blond_dog'
          ),
        ]
      )
    );
    register(
      Player(
        countFrames: 1,
        textureSize: Vector2(128, 128),
        name: 'Эклер',
        sprites: [
          PetSprites(
            width: 544,
            height: 556,
            path: 'dog/child/brown/brown_dog'
          ),
          PetSprites(
            width: 628,
            height: 626,
            path: 'dog/teen/brown/brown_dog'
          ),
          PetSprites(
            width: 728,
            height: 728,
            path: 'dog/adult/brown/brown_dog'
          ),
        ]
      )
    );
    register(
      Player(
        countFrames: 1,
        textureSize: Vector2(128, 128),
        name: 'Топпинг',
        sprites: [
          PetSprites(
            width: 544,
            height: 556,
            path: 'dog/child/white/white_dog'
          ),
          PetSprites(
            width: 628,
            height: 626,
            path: 'dog/teen/white/white_dog'
          ),
          PetSprites(
            width: 728,
            height: 728,
            path: 'dog/adult/white/white_dog'
          ),
        ]
      )
    );
  }
}