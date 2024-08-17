import 'package:cloud_firestore/cloud_firestore.dart';

class Achievement {
  double currentAchievement;
  DateTime time;

  Achievement({required this.currentAchievement, required this.time});

  Achievement.fromFirestore(Map<String, dynamic> data)
      : currentAchievement = data['currentAchievement'] as double,
        time = (data['time'] as Timestamp).toDate();
}
