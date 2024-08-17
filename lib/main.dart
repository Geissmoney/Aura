import 'package:aura/firebase_options.dart';
import 'package:aura/services/auth_service.dart';
import 'package:aura/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Poppins",
        ),
        home: const Auth());
  }
}

class Auth extends StatefulWidget {
  const Auth({super.key});
  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.authState,
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        final User? user = snapshot.data;
        if (user == null) {
          // return const LoginPage(); TODO: Implement LoginPage
          return Center(
            child: MaterialButton(
              color: Colors.blue,
              child: const Text('Test sign in'),
              onPressed: () async {
                await _auth.signInAnon();
              },
            ),
          );
        } else {
          final databaseService = DatabaseService(uid: user.uid);
          return Provider<DatabaseService>(
            create: (context) => databaseService,
            builder: (context, child) {
              return const HomePage();
            },
          );
        }
      },
    );
  }
}
