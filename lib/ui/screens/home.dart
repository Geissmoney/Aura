import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 10,
        title: const Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(
            'Aura',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.amber,
          labelColor: Colors.amber,
          unselectedLabelColor: Colors.white,
          tabs: const [Tab(text: 'You'), Tab(text: 'Friends')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          // Content for 'You' tab
          Center(child: Text('Welcome to Your Page')),
          // Content for 'Friends' tab
          Center(child: Text('Friends Page')),
        ],
      ),
    );
  }
}
