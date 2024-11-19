import 'package:flutter/material.dart';
import 'package:its_rent_hub/home_page.dart';
import 'package:its_rent_hub/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/home': (context) => const HomePage(),
      },
      theme: ThemeData(
        fontFamily: 'Poppins', // Set Poppins as the default font
      ),
    );
  }
}
