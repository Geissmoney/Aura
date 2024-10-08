import 'package:aura/firebase_options.dart';
import 'package:aura/services/auth_service.dart';
import 'package:aura/services/database_service.dart';
import 'package:aura/ui/screens/emailLogin.dart';
import 'package:aura/ui/screens/emailSignup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
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
    return GlobalLoaderOverlay(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          hintColor: Colors.deepPurpleAccent,
          buttonTheme: const ButtonThemeData(
            buttonColor: Colors.deepPurple,
            textTheme: ButtonTextTheme.primary,
          ),
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            actionsIconTheme: IconThemeData(color: Colors.white),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple,
          ),
          fontFamily: "Poppins",
        ),
        routes: {
          '/home': (context) => const HomePage(),
          '/login': (context) => const EmailLogin(),
          '/signup': (context) => const EmailSignup(),
          '/': (context) => const EmailLogin(),
        },
      ),
    );
  }
}

// class Auth extends StatefulWidget {
//   const Auth({super.key});
//   @override
//   State<Auth> createState() => _AuthState();
// }
//
// class _AuthState extends State<Auth> {
//   final AuthService _auth = AuthService();
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: _auth.authState,
//       builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
//         User? user = null;
//         if (user == null) {
//           return EmailLogin(); // TODO: Implement LoginPage
//         } else {
//           final databaseService = DatabaseService(uid: user.uid);
//           return Provider<DatabaseService>(
//             create: (context) => databaseService,
//             builder: (context, child) {
//               return const HomePage();
//             },
//           );
//         }
//       },
//     );
//   }
// }
