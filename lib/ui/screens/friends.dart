import 'package:flutter/material.dart';

class FriendsHome extends StatefulWidget {
  const FriendsHome({super.key});

  @override
  State<FriendsHome> createState() => _FriendsHomeState();
}

class _FriendsHomeState extends State<FriendsHome> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child:Column(
        children: [
          Padding(padding: EdgeInsets.all(20.0)),
          CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage('assets/images/avatar.png'),
          ),
          Padding(padding: EdgeInsets.all(5.0)),
          Text("User Name", style: TextStyle(fontSize: 30),),
          Padding(padding: EdgeInsets.all(20.0)),

        ],
      )
    );
  }
}
