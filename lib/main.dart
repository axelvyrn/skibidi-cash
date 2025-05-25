import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // make sure this matches your folder

void main() {
  runApp(const SkibidiApp());
}

class SkibidiApp extends StatelessWidget {
  const SkibidiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skibidi Wallet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'RobotoMono', color: Colors.white),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'RobotoMono',
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
