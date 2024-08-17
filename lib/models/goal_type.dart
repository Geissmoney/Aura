class GoalType {
  int id;
  String type;
  double difficulty;

  GoalType({required this.id, required this.difficulty, required this.type});

  GoalType.fromFirestore(Map<String, dynamic> data)
      : id = data['id'] as int,
        type = data['type'] as String,
        difficulty = data['difficulty'] as double;
}
