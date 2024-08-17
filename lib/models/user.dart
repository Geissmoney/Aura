import 'package:aura/models/day.dart';

class UserModel {
  String name;
  List<Day> days;

  UserModel({required this.name, required this.days});

  UserModel.fromFirestore(Map<String, dynamic> data)
      : name = data['display_name'],
        days = data['days'];
}
