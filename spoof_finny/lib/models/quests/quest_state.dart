import 'package:hive_ce/hive_ce.dart';

part 'quest_state.g.dart';

@HiveType(typeId: 50)
enum QuestState{
  @HiveField(0)
  active,
  @HiveField(1)
  fail,
  @HiveField(2)
  completed,
  @HiveField(3)
  expired,
}