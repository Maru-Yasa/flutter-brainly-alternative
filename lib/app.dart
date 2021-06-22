import 'package:flutter/material.dart';
import 'screens/brainly_screen/brainly_screen.dart';
import 'style.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BrainlyScreen(),
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          textTheme: TextTheme(
            headline1: headline1Style,
            headline2: headline2Style,
            bodyText1: bodyText1Style,
          )),
    );
  }
}
