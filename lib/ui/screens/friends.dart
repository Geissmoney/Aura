import 'package:aura/main.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class FriendsHome extends StatefulWidget {
  const FriendsHome({super.key});

  @override
  State<FriendsHome> createState() => _FriendsHomeState();
}

class _FriendsHomeState extends State<FriendsHome> {
  List<String> _friends = [];
  List<String> _requests = [];
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: (){
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    body: SizedBox(
                      width: MediaQuery.sizeOf(context).width * .7,
                      child: Column(
                        children: [],
                      ),
                    )

                  ).show();
                }, icon: const Icon(Icons.history_edu,size: 40,),),
                Expanded(child: Container()),
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
                                  sendRequest();
                                }),
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Username',
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
            const Padding(padding: EdgeInsets.all(5.0)),
            Text("Username - ${selfName.substring(0,5).toLowerCase()}", style: const TextStyle(fontSize: 20),),
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
    context.loaderOverlay.show();
    await FirebaseFirestore.instance
        .collection('users').where('code',isEqualTo: addUsr).limit(1)
        .get().then((event) async {
          print(addUsr);
          print("----------------------------------");
          for (var doc in event.docs) {
            await FirebaseFirestore.instance
                .collection('users').doc(FirebaseAuth.instance.currentUser?.uid.toString())
                .collection('friends').add({
              'status':'pending',
              'uid' : doc.id,
              'time' : DateTime.now(),
            });
            await FirebaseFirestore.instance
                .collection('users').doc(doc.id)
                .collection('friends').add({
              'status' : 'awaiting',
              'uid' : FirebaseAuth.instance.currentUser?.uid,
              'time' : DateTime.now(),
            });
          }
    });
    context.loaderOverlay.hide();
  }

  getFriends() {
    setState(() {
      _friends.clear();
      _requests.clear();
      selfName = FirebaseAuth.instance.currentUser!.displayName!;
      FirebaseFirestore.instance
          .collection('users').doc(FirebaseAuth.instance.currentUser?.uid.toString())
          .collection('friends').where('status', isEqualTo: 'accepted').get().then((event) {
        for (var doc in event.docs) {
          _friends.add(doc['uid']);
        }
      });
      FirebaseFirestore.instance
          .collection('users').doc(FirebaseAuth.instance.currentUser?.uid.toString())
          .collection('friends').where('status', isEqualTo: 'awaiting').get().then((event) {
        for (var doc in event.docs) {
          _requests.add(doc['uid']);
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
