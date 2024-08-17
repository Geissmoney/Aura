import 'dart:ui';

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

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final List<Widget> _screens = [const FriendsHome(), const HomeScreen(), const Leaderboard()];
  int _currentIndex = 1;
  double ballSize = 100;

  late AnimationController _animationController;
  bool isMenuOpen = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      

    );
  }

  @override
  void dispose() {
    // _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void toggleMenu() {
    isMenuOpen = !isMenuOpen;
  }

  void showMenuOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ActionButton(icon: Icons.workspace_premium_rounded, label: "Set Goal", onTap: () => print("Set a Goal")),
            ActionButton(icon: Icons.auto_stories, label: "Journal", onTap: () => print("Journalling")),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => showMenuOptions(),
        child: const Icon(Icons.add),
      ),

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
            CustomBallWidget(size: 50, label: "Aura Number"),
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

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ActionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: onTap,
    );
  }
}
