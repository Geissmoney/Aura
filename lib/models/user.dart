class UserModel {
  String name;

  UserModel({required this.name});

  UserModel.fromFirestore(Map<String, dynamic> data)
      : name = data['display_name'];
}
