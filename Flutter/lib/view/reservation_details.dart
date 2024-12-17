import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:its_rent_hub/api/api_globals.dart';
import 'package:its_rent_hub/api/reservation.dart';
import 'package:its_rent_hub/components/availability.dart';
import 'package:its_rent_hub/models/reservation.dart';
import 'package:its_rent_hub/view/home.dart';
import 'package:its_rent_hub/view/login.dart';

class ReservationDetailsPage extends StatefulWidget {
  final String reservationID;

  const ReservationDetailsPage({super.key, required this.reservationID});

  @override
  _ReservationDetailsPageState createState() => _ReservationDetailsPageState();
}

class _ReservationDetailsPageState extends State<ReservationDetailsPage> {
  ReservationDetailsData? res;
  var isLoaded = false;

  TextEditingController cStartDate = TextEditingController();
  TextEditingController cEndDate = TextEditingController();
  TextEditingController cStartTime = TextEditingController();
  TextEditingController cEndTime = TextEditingController();

  @override
  void initState(){
    super.initState();
    _getData(widget.reservationID);
  }

  void _getData(reservationID) async {
    ReservationDetailsResponse? response = await ReservationAPIService().reservationDetails(reservationID);
    if (response != null) {
      setState(() {
        res = response.data;
        isLoaded = true;
        List<String>? start = res?.startDate.split(" ");
        List<String>? end = res?.endDate.split(" ");
        cStartDate.text = start?[0] ?? '';
        cEndDate.text = end?[0] ?? '';
        cStartTime.text = start?[1] ?? '';
        cEndTime.text = end?[1] ?? '';
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${res?.roomName}",
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
                  Text(
                    "Lokasi: ${res?.location ?? ''}",
                    style: const TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Kapasitas: ${res?.capacity ?? ''}",
                    style: const TextStyle(fontSize: 16, fontFamily: 'Poppins'),
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: res?.facilities?.length ?? 0,
                    itemBuilder: (context, index) {
                        return Text("• ${res?.facilities?[index] ?? ''}",
                          style: const TextStyle(
                            fontFamily: 'Poppins'
                          ),
                        );
                    },
                  ),
                  const SizedBox(height: 16),
                  availibilityBox(res?.roomId, cStartDate, cEndDate, cStartTime, cEndTime),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          print("update button pressed");
                          String start = '${cStartDate.text} ${cStartTime.text}';
                          String end = '${cEndDate.text} ${cEndTime.text}';
                          ReservationDetailsResponse? res = await ReservationAPIService().updateReservation(widget.reservationID, start, end);
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
                              msg: res.error ?? 'Failed to Update Reservation',
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
                            msg: 'Room Reservation Updated',
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
                        onPressed: () async {
                          print("delete button pressed");
                          DeleteReservationResponse? res = await ReservationAPIService().deleteReservation(widget.reservationID);
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
                              msg: res.error ?? 'Failed to Delete',
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
                            msg: 'Delete Success',
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
                              builder: (context) => const HomePage(),
                            ),
                          );
                        },
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
