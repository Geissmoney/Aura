import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailSignup extends StatefulWidget {
  const EmailSignup({super.key});

  @override
  State<EmailSignup> createState() => _EmailSignupState();
}

class _EmailSignupState extends State<EmailSignup> {
  String pass = "";
  bool isHidden = true;
  String email = "";
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aura"),
      ),
      body: Center(
        child: SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width * .8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.all(8)),
                const Text('Sign Up', style: TextStyle(fontSize: 30)),
                const Padding(padding: EdgeInsets.all(8)),
                TextField(
                  onChanged: ((value) {
                    name = value;
                  }),
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
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
                ElevatedButton(
                  onPressed: () {
                    signUp(context);
                  },
                  child: const Text('Welcome'),
                ),
              ],
            )
        ),
      ),
    );
  }

  Future<void> signUp(BuildContext context) async {
    context.loaderOverlay.show();
    email = email.trim();
    pass = pass.trim();
    name = name.trim();
    if (email.isEmpty || pass.isEmpty || name.isEmpty) {
      context.loaderOverlay.hide();
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid.toString()).set(
          {
            'name': name.toString(),
            'aura': 0,
            'code': name.substring(0,5),
          });
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      context.loaderOverlay.hide();
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
