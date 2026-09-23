import 'package:spoof_finny/models/game_events/game_event.dart';

class BuyGameEvent extends GameEvent {
  final String itemName;
  final int count;
  final double totalPrice;

  const BuyGameEvent({
    required this.itemName,
    required this.count,
    required this.totalPrice,
  });

}
