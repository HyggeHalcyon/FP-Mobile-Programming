import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:its_rent_hub/api/api_globals.dart';
import 'package:its_rent_hub/api/reservation.dart';
import 'package:its_rent_hub/api/room.dart';
import 'package:its_rent_hub/components/availability.dart';
import 'package:its_rent_hub/models/reservation.dart';
import 'package:its_rent_hub/models/room.dart';
import 'package:its_rent_hub/view/home.dart';
import 'package:its_rent_hub/view/login.dart';
import 'package:its_rent_hub/view/room_search.dart';

class RoomDetailsPage extends StatefulWidget {
  final String roomID;

  const RoomDetailsPage({super.key, required this.roomID});

  @override
  _RoomDetailsPageState createState() => _RoomDetailsPageState();
}

class _RoomDetailsPageState extends State<RoomDetailsPage> {
  RoomDetailsData? room;
  var isLoaded = false;

  TextEditingController cStartDate = TextEditingController();
  TextEditingController cEndDate = TextEditingController();
  TextEditingController cStartTime = TextEditingController();
  TextEditingController cEndTime = TextEditingController();

  @override
  void initState(){
    super.initState();
    _getData(widget.roomID);
  }

  void _getData(roomID) async {
    RoomDetailsReponse? response = await RoomAPIService().getDetails(roomID);
    if (response != null) {
      setState(() {
        room = response.data;
        isLoaded = true;
      });
    } else {
      setState(() {
        isLoaded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isAuthenticed == false) {
      return const LoginPage();
    }

    if (widget.roomID == '') {
      return const RoomSearch();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Room Details',
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
            if (!isLoaded)
              const Center(child: CircularProgressIndicator())
            else
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        room?.name ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Yuk, booking ruangan di sini!",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 18),
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
                  Text(
                    "Lokasi: ${room?.name ?? ''}",
                    style: const TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Kapasitas: ${room?.capacity ?? ''}",
                    style: const TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Fasilitas:",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: room?.facilities.length ?? 0,
                    itemBuilder: (context, index) {
                      return Text(
                        "• ${room?.facilities[index] ?? ''}",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  availibilityBox(widget.roomID, cStartDate, cEndDate, cStartTime, cEndTime),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        String start = '${cStartDate.text} ${cStartTime.text}';
                        String end = '${cEndDate.text} ${cEndTime.text}';
                        ReservationDetailsResponse? res = await ReservationAPIService().createReservation(widget.roomID, start, end);
                        if (res == null) {
                          Fluttertoast.showToast(
                            msg: 'Error Making Request',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            timeInSecForIosWeb: 2,
                            webPosition: "center",
                            webBgColor: "linear-gradient(to right, #dc1c13, #dc1c13)",
                          );
                          return;
                        }

                        if (res.status == false) {
                          Fluttertoast.showToast(
                            msg: res.error ?? 'Failed to Reserve Room',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            timeInSecForIosWeb: 2,
                            webPosition: "center",
                            webBgColor: "linear-gradient(to right, #dc1c13, #dc1c13)",
                          );
                          return;
                        }

                        Fluttertoast.showToast(
                          msg: 'Room Reservation Success',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          timeInSecForIosWeb: 2,
                          webPosition: "center",
                          webBgColor: "linear-gradient(to right, #19C63C, #19C63C)",
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Ajukan Peminjaman",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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