import 'package:aura/models/achievement.dart';

class Goal {
  int goalType;
  List<Achievement> achievements;
  double target;

  Goal(
      {required this.goalType,
      required this.achievements,
      required this.target});
}
