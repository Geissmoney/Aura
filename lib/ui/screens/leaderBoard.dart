import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';  

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  List<Map<String, dynamic>> _leaderBoardItems = [];

  @override
  void initState() {
    super.initState();
    generateDummyData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _leaderBoardItems.length,
      itemBuilder: (BuildContext context, int index) {
        final item = _leaderBoardItems[index];
        return buildList(context, index, item['name'], item['auraPoints']);
      },
    );
  }

  Widget buildList(BuildContext context, int index, String name, int auraPoints) {
    int ind = index + 1;

    Widget aura;

    if (ind == 1) {
      aura = _buildAura(FontAwesomeIcons.solidLightbulb, Colors.yellow, '1');  // Replace with appropriate icon
    } else if (ind == 2) {
      aura = _buildAura(FontAwesomeIcons.solidLightbulb, Colors.grey[300]!, '2');
    } else if (ind == 3) {
      aura = _buildAura(FontAwesomeIcons.solidLightbulb, Colors.orange[300]!, '3');
    } else {
      aura = CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 13,
        child: Text(
          ind.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
      child: Container(
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5.0)],
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: Row(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 25),
                          child: aura,
                        ),
                      ),
                      const Align(
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Text('GI'),
                          radius: 30,
                        ),
                      ),
                      Align(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 5),
                              child: Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$auraPoints pts',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAura(IconData icon, Color color, String rank) {
    return Padding(
      padding: const EdgeInsets.only(right: 0.0),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(child: Icon(icon, size: 36, color: color)),  // Using Material Icon
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 6),
            child: Center(
              child: Text(
                rank,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void generateDummyData() {
    _leaderBoardItems = List.generate(10, (index) {
      return {
        "name": "User ${index + 1}",
        "auraPoints": (1000 - index * 50) 
      };
    });
  }
}
