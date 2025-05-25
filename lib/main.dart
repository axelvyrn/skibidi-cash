import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(SkibidiCashApp());
}

class SkibidiCashApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skibidi Cash',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.limeAccent, fontSize: 18),
        ),
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}