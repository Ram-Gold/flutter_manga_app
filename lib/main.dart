import 'package:flutter/material.dart';
import 'screen/main_wrapper.dart'; // Import natin yung wrapper

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Para dark mode agad
      home: const MainWrapper(),
    );
  }
}