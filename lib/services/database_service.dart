import 'package:aura/models/goal.dart';
import 'package:aura/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Stream<UserModel> get userStream {
    return userCollection.doc(uid).snapshots().map(
      (doc) {
        return UserModel.fromFirestore(doc.data() as Map<String, dynamic>);
      },
    );
  }

  Future<void> updateAura(int aura) async {
    return await userCollection.doc(uid).update({'aura': aura});
  }

  Future<void> updateName(String name) async {
    return await userCollection.doc(uid).update({'name': name});
  }

  // List of friend uids
  Stream<List<String>> get friends {
    return userCollection
        .doc(uid)
        .collection('friends')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.where((doc) {
        return doc.data()['status'] == 'friend';
      }).map((doc) {
        return doc.id;
      }).toList();
    });
  }

  Stream<UserModel> userModelStream(String uid) {
    return userCollection.doc(uid).snapshots().map(
      (doc) {
        return UserModel.fromFirestore(doc.data() as Map<String, dynamic>);
      },
    );
  }

  Future<void> sendFriendRequest(String friendUid) async {
    final batch = FirebaseFirestore.instance.batch();
    batch.set(
      userCollection.doc(uid).collection('friends').doc(friendUid),
      {
        'status': 'sent',
      },
    );
    batch.set(
      userCollection.doc(friendUid).collection('friends').doc(uid),
      {
        'status': 'received',
      },
    );
    return await batch.commit();
  }

  Future<void> acceptFriendRequest(String friendUid) async {
    final batch = FirebaseFirestore.instance.batch();
    batch.update(
      userCollection.doc(uid).collection('friends').doc(friendUid),
      {
        'status': 'friend',
      },
    );
    batch.update(
      userCollection.doc(friendUid).collection('friends').doc(uid),
      {
        'status': 'friend',
      },
    );
    return await batch.commit();
  }

  Future<void> declineFriendRequest(String friendUid) async {
    final batch = FirebaseFirestore.instance.batch();
    batch.delete(
      userCollection.doc(uid).collection('friends').doc(friendUid),
    );
    batch.delete(
      userCollection.doc(friendUid).collection('friends').doc(uid),
    );
    return await batch.commit();
  }

  Future<void> createGoal(Goal goal) async {
    await userCollection.doc(uid).collection('goals').add(goal.toFirestore());
  }

  Stream<List<Goal>> get goals {
    return userCollection.doc(uid).collection('goals').snapshots().map(
      (snapshot) {
        return snapshot.docs.map(
          (doc) {
            return Goal.fromFirestore(doc.data());
          },
        ).toList();
      },
    );
  }
}
