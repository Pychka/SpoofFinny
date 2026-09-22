import 'package:spoof_finny/models/game_object.dart';

class Item extends GameObject{
  bool canStack;
  int count;
  Item({
    required super.name,
    this.count = 0,
    this.canStack = true
  });

}