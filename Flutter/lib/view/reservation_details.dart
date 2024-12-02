import 'package:flutter/material.dart';
import 'package:its_rent_hub/api/api_globals.dart';
import 'package:its_rent_hub/components/availability.dart';
import 'package:its_rent_hub/models/reservation.dart';
import 'package:its_rent_hub/view/login.dart';

class ReservationDetailsPage extends StatefulWidget {
  final String reservationID;

  const ReservationDetailsPage({super.key, required this.reservationID});

  @override
  _ReservationDetailsPageState createState() => _ReservationDetailsPageState();
}

class _ReservationDetailsPageState extends State<ReservationDetailsPage> {
  MyReservationData? room;
  var isLoaded = false;

  @override
  void initState(){
    super.initState();
    _getData(widget.reservationID);
  }

  void _getData(roomID) async {
    
  }

  @override
  Widget build(BuildContext context) {
    if (isAuthenticed == false) {
      return const LoginPage();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Reservation Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Research Center",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Yuk, booking ruangan di sini!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "Lokasi: Gedung Research Center",
                    style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Kapasitas: 120",
                    style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Fasilitas:",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 4),
                  const Text("• Microphone",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      )),
                  const Text("• LCD Screen",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      )),
                  const Text("• Speaker",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      )),
                  const Text("• Microphone",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      )),
                  const SizedBox(height: 16),
                  availibilityBox(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Update",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Delete",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
