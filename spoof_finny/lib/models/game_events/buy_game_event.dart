import 'package:spoof_finny/models/game_events/time_skipped.dart';

class BuyGameEvent extends TimeSkipped {
  final String itemName;
  final int count;
  final double totalPrice;

  BuyGameEvent({
    required this.itemName,
    required this.count,
    required this.totalPrice, required super.timeChangedEvent,
  });

}
