import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aura/services/database_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  double ballSize = 100; // This can be dynamically adjusted as needed

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20), // Top padding for the ball
            CustomBallWidget(size: ballSize, label: "${ballSize.toInt()}"),
            const SizedBox(height: 20), // Space between the ball and the cards
            // Add your cards and other components here
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Some information here"),
              ),
            ),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
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
