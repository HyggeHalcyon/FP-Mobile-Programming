import 'package:flutter/material.dart';
import 'package:its_rent_hub/form_create.dart';
import 'package:its_rent_hub/home.dart';
import 'package:its_rent_hub/manage_room_details.dart';
import 'package:its_rent_hub/room_details.dart';
import 'package:its_rent_hub/welcome_page.dart';
import 'package:its_rent_hub/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage1(),
        '/form': (context) => const FormCreatePage(),
        '/roomDetails': (context) => const RoomDetailsPage(),
        '/manageRoomDetails': (context) =>
            const ManageRoomDetailsPage(), // New route
      },
      theme: ThemeData(
        fontFamily: 'Poppins', // Set Poppins as the default font
      ),
    );
  }
}
