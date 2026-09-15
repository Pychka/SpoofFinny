import 'package:flame/components.dart';
import 'package:flame/events.dart';

class InteractiveArea extends PositionComponent with TapCallbacks {
  final Function() onTapAction;

  InteractiveArea({
    required super.position,
    required super.size,
    required this.onTapAction,
    super.anchor,
  });

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    onTapAction();
  }
}