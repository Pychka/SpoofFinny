import 'dart:math';
import 'package:hive/hive.dart';

part 'experience_system.g.dart';

@HiveType(typeId: 10)
class ExperienceSystem {
  @HiveField(0)
  int currentLevel = 0;
  @HiveField(1)
  int currentExperience = 0;
  int nextLevelExperience = 20;
  @HiveField(2)
  final int factor;

  ExperienceSystem(
    this.currentLevel,
    this.currentExperience,
    this.factor
  ){
    nextLevelExperience = _getNextLevelExperience();
  }

  void addExperience(int experience){
    currentExperience = experience;
    while(currentExperience >= nextLevelExperience){
      currentLevel++;
      nextLevelExperience = _getNextLevelExperience();
    }
  }

  int _getNextLevelExperience() => ((pow(currentLevel + 1, 2) / 2).floor() - currentLevel + 1) * factor;
}