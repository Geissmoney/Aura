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
}
