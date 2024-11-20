import 'package:flutter/material.dart';
import 'form_create.dart';
import 'room_details.dart';
import 'manage_room_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Room Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FormCreatePage(),
      routes: {
        '/roomDetails': (context) => const RoomDetailsPage(), // Existing route
        '/manageRoomDetails': (context) =>
            const ManageRoomDetailsPage(), // New route
      },
    );
  }
}
