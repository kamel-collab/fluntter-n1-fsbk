import 'package:first/screens/detail_screen.dart';
import 'package:first/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      home: HomeScreen(),
      routes: {DetailScreen.route: (context) => DetailScreen()},
    );
  }
}
