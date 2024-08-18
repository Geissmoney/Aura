import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  String pass = "";
  bool isHidden = true;
  String email = "";

  @override
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    context.loaderOverlay.hide();
    WidgetsBinding.instance.addPostFrameCallback((_){
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    });
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     //TODO: Go back button
        //   },
        //   color: Colors.black,
        // ),
        title: const Text("Aura"),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.all(8)),
              const Text('Login', style: TextStyle(fontSize: 30)),
              const Padding(padding: EdgeInsets.all(8)),
              TextField(
                onChanged: ((value) {
                  email = value;
                }),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email-ID',
                ),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              TextField(
                //controller:,
                onChanged: ((value) {
                  pass = value;
                }),
                obscureText: isHidden,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      isHidden ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
              ),
              const Padding(padding: EdgeInsets.all(8)),
              TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text('New around here? Sign Up'),
              ),
              const Padding(padding: EdgeInsets.all(8)),
              ElevatedButton(
                onPressed: () {
                  emailAuth(context);
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> emailAuth(BuildContext context) async {
    context.loaderOverlay.show();
    email = email.trim();
    pass = pass.trim();
    if (email.isEmpty || pass.isEmpty) {
      context.loaderOverlay.hide();
      return;
    }
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
      } else {
        //Unhandled Login Errors
        if (kDebugMode) {
          print(e.code);
        }
      }
      context.loaderOverlay.hide();
      return;
    }
    //TODO: Go to Home Page
    context.loaderOverlay.hide();
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }
}
