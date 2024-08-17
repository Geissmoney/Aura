import 'package:flutter/material.dart';

import 'friends.dart';
import 'leaderBoard.dart';
import 'package:provider/provider.dart';
import 'package:aura/services/database_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _screens = [const FriendsHome(), const HomeScreen(), const Leaderboard()];
  int _currentIndex = 0;
  double ballSize = 100;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final databaseService = Provider.of<DatabaseService>(context);
    // You can use databaseService to fetch data that might influence _ballSize

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            'Aura',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
          ),
        ],
      ),
      body: _screens[_currentIndex],

    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20), // Top padding for the ball
            CustomBallWidget(size: 50, label: "50"),
            SizedBox(height: 20), // Space between the ball and the cards
            // Add your cards and other components here
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Some information here"),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Another piece of information here"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBallWidget extends StatelessWidget {
  final double size;
  final String label;

  const CustomBallWidget({super.key, required this.size, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: BallPainter(size),
        child: Container(
          width: size * 2,
          height: size * 2,
          alignment: Alignment.center,
          child: Text(label, style: TextStyle(color: Colors.white, fontSize: size / 4)),
        ),
      ),
    );
  }
}

class BallPainter extends CustomPainter {
  final double size;

  BallPainter(this.size);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawCircle(size.center(Offset.zero), this.size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
