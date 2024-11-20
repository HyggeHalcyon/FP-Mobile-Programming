import 'package:flutter/material.dart';
import 'package:its_rent_hub/form_create.dart';
import 'package:its_rent_hub/home.dart';
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
        '/home': (context) => const HomePage1(),
        '/form': (context) => const FormCreatePage(),
      },
      theme: ThemeData(
        fontFamily: 'Poppins', // Set Poppins as the default font
      ),
    );
  }
}
