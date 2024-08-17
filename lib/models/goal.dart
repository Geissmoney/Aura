import 'package:aura/models/achievement.dart';

class Goal {
  int goalType;
  List<Achievement> achievements;
  double target;

  Goal(
      {required this.goalType,
      required this.achievements,
      required this.target});

  Goal.fromFirestore(Map<String, dynamic> data)
      : goalType = data['goalType'] as int,
        achievements =
            (data['achievements'] as Iterable<dynamic>).map((achievement) {
          return Achievement.fromFirestore(achievement as Map<String, dynamic>);
        }).toList(),
        target = data['target'] as double;
}
