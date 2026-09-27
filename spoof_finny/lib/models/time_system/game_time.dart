import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
part 'game_time.g.dart';

@HiveType(typeId: 28)
class GameTime {
  @HiveField(0)
  int totalSecondsValue = 0;
  
  ValueNotifier<int> totalSecondsValueNotifier = ValueNotifier(0);

  GameTime({required this.totalSecondsValue});

  static const int factor = 12;
  static const int secondsInYear = 946_080_000;
  static const int secondsInMonth = 2_592_000;
  static const int secondsInDay = 86_400;
  static const int secondsInHour = 3_600;
  static const int secondsInMinute = 60;

  int get totalSeconds => totalSecondsValue;

  int get year => totalSeconds ~/ secondsInYear + 2026;
  int get month => totalSeconds % secondsInYear ~/ secondsInMonth + 1;
  int get day => totalSeconds % secondsInMonth ~/ secondsInDay + 1;
  int get hour => totalSeconds % secondsInDay ~/ secondsInHour;
  int get minute => totalSeconds % secondsInHour ~/ secondsInMinute;

  String get formatShortTime => '${_numToStringWithPad(num: hour)}:${_numToStringWithPad(num: minute)}';

  String get formatShortDate => '${_numToStringWithPad(num: day)}.${_numToStringWithPad(num: month)}';

  String get formatShortTimeWithDate => '${_numToStringWithPad(num: hour)}:${_numToStringWithPad(num: minute)} ${_numToStringWithPad(num: day)}.${_numToStringWithPad(num: month)}';

  String get formatFull => '${_numToStringWithPad(num: hour)}:${_numToStringWithPad(num: minute)} ${_numToStringWithPad(num: day)}.${_numToStringWithPad(num: month)}.${_numToStringWithPad(num: year, count: 4)}';
  
  bool get isNight => hour < 6 || hour > 22;

  set totalSeconds(int value){
    totalSecondsValue = value;
    totalSecondsValueNotifier.value = value;
  }

  void tickInMinutes(int minutesToApprove) =>
    tickInSeconds(minutesToApprove * secondsInMinute);
    
  void tickInSeconds(int secondsToApprove) =>
    totalSeconds += secondsToApprove;
  
  void tickInRealSeconds(int seconds) =>
    totalSeconds += seconds * factor;
  
  void addSeconds(int seconds) =>
    tickInSeconds(seconds);

  void addDays(int days) => tickInSeconds(days * secondsInDay);

  void addHours(int hours) => tickInSeconds(hours * secondsInHour);

  void addMinutes(int minutes) => tickInSeconds(minutes * secondsInMinute);

  GameTime get createNew => GameTime(totalSecondsValue: totalSeconds)..init();

  void init(){
    totalSecondsValueNotifier.value = totalSecondsValue;
  }

  String _numToStringWithPad({required int num, int count = 2}) => num.toString().padLeft(count, '0');
}