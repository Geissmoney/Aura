import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
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
        backgroundColor: Colors.deepPurple, // Set a custom background color
        elevation: 10, // Adds shadow beneath the AppBar
        title: const Padding(
        padding: EdgeInsets.only(top: 10.0),  // Adjust the padding value as needed
          child: Text(
            'Aura',
            style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true, // Center the title
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.amber, // Color of the tab indicator
          labelColor: Colors.amber, // Color of the tab text when selected
          unselectedLabelColor: Colors.white, // Color of the tab text when unselected
          tabs: const [
            Tab(text: 'You'), // Tab 1
            Tab(text: 'Friends') // Tab 2
          ],
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

