import 'package:firebase_auth/firebase_auth.dart';
import 'package:result_dart/result_dart.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authState => _auth.authStateChanges();

  // sign in anonymously
  Future<Result<User, FirebaseAuthException>> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      return Success(user);
    } on FirebaseAuthException catch (e) {
      return Failure(e);
    }
  }

  // sign in with email and password
  Future<Result<User, FirebaseAuthException>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return Success(user);
    } on FirebaseAuthException catch (e) {
      return Failure(e);
    }
  }

  // register with email and password
  Future<Result<User, FirebaseAuthException>> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return Success(user);
    } on FirebaseAuthException catch (e) {
      return Failure(e);
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
