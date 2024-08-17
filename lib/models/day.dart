import 'package:aura/models/goal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Day {
  DateTime date;
  List<Goal> goals;

  Day({required this.date, required this.goals});

  Day.fromFirestore(Map<String, dynamic> data)
      : date = (data['date'] as Timestamp).toDate(),
        goals = (data['goals'] as Iterable<dynamic>).map((goal) {
          return Goal.fromFirestore(goal as Map<String, dynamic>);
        }).toList();
}
