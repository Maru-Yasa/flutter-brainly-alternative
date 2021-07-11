import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import '../brainly_screen/brainly_screen.dart';
import '../wikipedia_screen/wikipedia_screen.dart';

List<Widget> page = [
  BrainlyScreen(),
  WikipediaScreen(),
];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      body: Center(
        child: page[currentPage],
      ),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(
            iconData: Icons.grading,
            title: 'Brainly',
          ),
          TabData(
            iconData: Icons.book,
            title: 'Wikipedia',
          ),
        ],
        onTabChangedListener: (index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
    );
  }
}
