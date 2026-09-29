import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:spoof_finny/models/game_events/change_stat_value_game_event.dart';
import 'package:spoof_finny/models/game_state.dart';
import 'package:spoof_finny/models/interactives/interactive_area.dart';
import 'package:spoof_finny/models/stats/operator.dart';
import 'package:spoof_finny/models/stats/stat_value_state.dart';
import 'package:spoof_finny/models/time_system/game_time.dart';
import 'package:spoof_finny/models/time_system/game_time_changed_event.dart';

class BathroomScreen extends FlameGame with HasGameReference {
  BathroomScreen({required this.changeScreen});
  SpriteComponent? background;
  final Function(int) changeScreen;
  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Wait assets :)
    background = SpriteComponent()
      ..sprite = await loadSprite("bathroom/background.png")
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
    add(goBack);
    final teethbrushStat = GameState.instance.userInfo.statManager.getStat('teethbrush');
    //final bathStat = GameState.instance.userInfo.statManager.getStat('shower');
    //final toiletStat = GameState.instance.userInfo.statManager.getStat('toilet');
    final hygiene = GameState.instance.userInfo.statManager.getStat('hygiene');
    final sink = InteractiveArea(
      relativeX: 0.03515625,
      relativeY: 0.189453125,
      relativeWidth: 0.236328125,
      relativeHeight: 0.640625,
      onTapAction: () {
        if(teethbrushStat.state() != StatValueState.critMax) return;
        GameState.instance.gameEventBus.actionHappen(
          GameTimeChangedEvent(
            from: GameTime(totalSecondsValue: 0),
            to:  GameTime(totalSecondsValue: 120)
            )
          );
        GameState.instance.gameEventBus.actionHappen(
          ChangeStatValueGameEvent(
            stat: teethbrushStat,
            value: 0,
            operator: Operator.change
            )
          );
          
        GameState.instance.gameEventBus.actionHappen(
          ChangeStatValueGameEvent(
            stat: hygiene,
            value: teethbrushStat.maxValue,
            operator: Operator.plus
            )
          );
      },
    );
    add(sink);

    // final bath = InteractiveArea(
    //   relativeX: 0.03515625,
    //   relativeY: 0.189453125,
    //   relativeWidth: 0.236328125,
    //   relativeHeight: 0.640625,
    //   onTapAction: () {
    //     if(bathStat.state() != StatValueState.critMax) return;
    //     GameState.instance.gameEventBus.actionHappen(
    //       ChangeStatValueGameEvent(
    //         stat: bathStat,
    //         value: 0,
    //         operator: Operator.change
    //         )
    //       );
          
    //     GameState.instance.gameEventBus.actionHappen(
    //       ChangeStatValueGameEvent(
    //         stat: hygiene,
    //         value: bathStat.maxValue,
    //         operator: Operator.plus
    //         )
    //       );
    //   },
    // );
    // add(bath);

    
  // final toilet = InteractiveArea(
  //   relativeX: 0.03515625,
  //   relativeY: 0.189453125,
  //   relativeWidth: 0.236328125,
  //   relativeHeight: 0.640625,
  //   onTapAction: () {
  //     if(toiletStat.state() != StatValueState.critMax) return;
  //     GameState.instance.gameEventBus.actionHappen(
  //       ChangeStatValueGameEvent(
  //         stat: toiletStat,
  //         value: 0,
  //         operator: Operator.change
  //         )
  //       );
        
  //     GameState.instance.gameEventBus.actionHappen(
  //       ChangeStatValueGameEvent(
  //         stat: hygiene,
  //         value: toiletStat.maxValue,
  //         operator: Operator.plus
  //         )
  //       );
  //   },
  // );
  // add(toilet);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    background?.size = size;
  }
}