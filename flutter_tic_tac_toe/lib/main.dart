import 'package:flutter/material.dart';
import 'screens/game.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  // adds the Game Screen from game.dart to the main page of the app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadGame(),
    );
  }
}
