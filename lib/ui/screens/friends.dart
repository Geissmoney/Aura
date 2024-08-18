import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FriendsHome extends StatefulWidget {
  const FriendsHome({super.key});

  @override
  State<FriendsHome> createState() => _FriendsHomeState();
}

class _FriendsHomeState extends State<FriendsHome> {
  List<String> _friends = [];
  String selfName = "";
  String addUsr = "";

  @override
  void initState() {
    super.initState();
    getFriends();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child:Column(
          children: [
            // const Padding(padding: EdgeInsets.all(20.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: (){
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        btnOkText: "Add",
                        btnOkOnPress: (){},
                        title: "Add Friend",
                        body: SizedBox(
                          width: MediaQuery.of(context).size.width * .7,
                          child: Column(
                            children: [
                              TextField(
                                onChanged: ((value) {
                                  addUsr = value.toString();
                                }),
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Username - ',
                                ),
                              )
                            ],
                          ),
                        )
                      ).show();
                    },
                    icon: const Icon(Icons.add,size: 40,),
                ),
              ],
            ),
            const CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
            const Padding(padding: EdgeInsets.all(5.0)),
            Text(selfName, style: const TextStyle(fontSize: 30),),
            const Padding(padding: EdgeInsets.all(20.0)),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height:MediaQuery.sizeOf(context).width *2 ,
              child: createHolder(),
            ),
          ],
        )
      ),
    );
  }

  sendRequest() async {
    await FirebaseFirestore.instance
        .collection('users').doc(FirebaseAuth.instance.currentUser?.uid.toString())
        .collection('friends').add({
      'status':'pending',
      'usr' : addUsr,
      'time' : DateTime.now(),
    });
  }

  getFriends() {
    setState(() {
      _friends.clear();
      selfName = FirebaseAuth.instance.currentUser!.displayName!;
      FirebaseFirestore.instance
          .collection('users').doc(FirebaseAuth.instance.currentUser?.uid.toString())
          .collection('friends').where('status', isEqualTo: 'accepted').get().then((event) {
        for (var doc in event.docs) {
          _friends.add(doc['uid']);
        }
      });
    });
  }

  Widget createHolder() {
    return ListView.builder(
      itemCount: _friends.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_friends[index]),
        );
      },
    );
  }


}
