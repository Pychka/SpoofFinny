import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:spoof_finny/models/game_events/change_stat_value_game_event.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/interactives/interactive_area.dart';
import 'package:spoof_finny/models/stats/operator.dart';
import 'package:spoof_finny/models/time_system/game_time.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';

class BedroomScreen extends FlameGame with HasGameReference {
  BedroomScreen({required this.changeScreen});
  SpriteComponent? background;
  final Function(int) changeScreen;
  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Wait assets :)
    background = SpriteComponent()
      ..sprite = await loadSprite("bedroom/background.png")
      ..size = size;
    add(background!);

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
    final fatigue = GameState.instance.userInfo.statManager.getStat('fatigue');
    final hygiene = GameState.instance.userInfo.statManager.getStat('hygiene');
    add(goBack);
    final bed = InteractiveArea(
      relativeX: 0.041015625,
      relativeY: 0.3828125,
      relativeWidth: 0.2454427083333333,
      relativeHeight: 0.26953125,
      onTapAction: () {
        if(GameState.instance.userInfo.timeManager.currentGameTime.isNight || fatigue.currentValue < fatigue.maxValue * 0.6){
          GameState.instance.gameEventBus.actionHappen(
            GameTimeChangedEvent(
              from: GameTime(totalSecondsValue: 0),
              to: GameTime(totalSecondsValue: 0)..addHours(8)
              )
            );
          GameState.instance.gameEventBus.actionHappen(
            ChangeStatValueGameEvent(
                stat: fatigue,
                value: (fatigue.maxValue * 0.8).toInt(),
                operator: Operator.plus
              )
            );
          GameState.instance.gameEventBus.actionHappen(
            ChangeStatValueGameEvent(
                stat: hygiene,
                value: (hygiene.maxValue * 0.6).toInt(),
                operator: Operator.minus
              )
            );
        }
      },
    );
    add(bed);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    background?.size = size;
  }
}