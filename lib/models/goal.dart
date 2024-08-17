import 'package:aura/models/goal_type.dart';

class Goal {
  GoalType type;
  double achieved;
  double target;

  Goal({
    required this.type,
    this.achieved = 0,
    required this.target,
  });

  Goal.fromFirestore(Map<String, dynamic> data)
      : type = GoalType.values[data['type']],
        achieved = data['achieved'] as double,
        target = data['target'] as double;

  Map<String, dynamic> toFirestore() {
    return {
      'type': type.index,
      'achieved': achieved,
      'target': target,
    };
  }
}
