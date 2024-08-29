import 'package:flutter/material.dart';
import 'src/screens/home_screen.dart';

// --------------------------------
void main() {
  runApp(const MyApp());
}
// --------------------------------

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      theme: ThemeData(
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(254, 206, 1, 1)),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
        ),
        primaryColor: const Color.fromRGBO(254, 206, 1, 1),
      ),
      home: const HomeScreen(),
    );
  }
}
