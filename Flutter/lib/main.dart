import 'package:flutter/material.dart';
import 'package:its_rent_hub/view/room_search.dart';
import 'package:its_rent_hub/view/home.dart';
import 'package:its_rent_hub/view/welcome.dart';
import 'package:its_rent_hub/view/login.dart';

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
        '/home': (context) => const HomePage(),
        '/form': (context) => const RoomSearch(),
        // '/roomDetails': (context) => const RoomDetailsPage(roomID: ''),
        // '/manageRoomDetails': (context) => const ReservationDetailsPage(reservationID: ''), 
      },
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
    );
  }
}
