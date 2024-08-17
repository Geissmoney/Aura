class UserModel {
  String name;
  int aura;

  UserModel({required this.name, this.aura = 0});

  UserModel.fromFirestore(Map<String, dynamic> data)
      : name = data['name'],
        aura = data['aura'] as int;

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'aura': aura,
    };
  }
}

class Friend {
  String status;

  Friend({required this.status});

  Friend.fromFirestore(Map<String, dynamic> data) : status = data['status'];

  Map<String, dynamic> toFirestore() {
    return {
      'status': status,
    };
  }
}

enum FriendStatus {
  sent,
  received,
  friend,
}
