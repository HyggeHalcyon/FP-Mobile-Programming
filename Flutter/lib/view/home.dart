import 'package:flutter/material.dart';
import 'package:its_rent_hub/api/api_globals.dart';
import 'package:its_rent_hub/api/reservation.dart';
import 'package:its_rent_hub/components/upperBar.dart';
import 'package:its_rent_hub/models/reservation.dart';
import 'package:its_rent_hub/view/login.dart';
import 'package:its_rent_hub/view/room_search.dart';
import 'package:its_rent_hub/view/reservation_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<MyReservationData>? reservation = [];
  var isLoaded = false;

  @override
  void initState(){
    super.initState();
    _getData();
  }

  void _getData() async {
    MyReservationResponse? response = await ReservationAPIService().myReservations();
    if (response != null) {
      setState(() {
        reservation = response.data;
        isLoaded = true;
      });
    } else {
      setState(() {
        isLoaded = false;
      });
    }
  }

  Color mapStatusToColor(String status) {
    switch (status) {
      case "Accepted":
        return const Color.fromARGB(255, 24, 197, 24);
      case "Rejected":
        return const Color.fromARGB(255, 202, 20, 20);
      case "Pending":
        return const Color.fromARGB(255, 173, 121, 38);
      default:
        return const Color.fromARGB(255, 21, 136, 21);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isAuthenticed == false) {
      return const LoginPage();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 800;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Home',
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
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: isDesktop ? 280 : 200, // Adjust top padding
                          bottom: 20,
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: isDesktop ? 800 : double.infinity,
                            ),
                            child: Column(
                              children: [
                                if (!isLoaded)
                                  const Center(child: CircularProgressIndicator())
                                else
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: reservation!.length,
                                    itemBuilder: (context, index) {
                                      return statusCard(
                                        context,
                                        reservation![index].roomName,
                                        reservation![index].roomPic,
                                        reservation![index].status,
                                        mapStatusToColor(reservation![index].status),
                                        reservation![index].id,
                                        reservation![index].capacity,
                                        "${reservation![index].startDate}",
                                        isDesktop,
                                      );
                                    },
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              upperBar(context, isDesktop)
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RoomSearch()),
              );
            },
            backgroundColor: Colors.yellow,
            child: const Icon(Icons.add, color: Colors.black),
          ),
        );
      },
    );
  }

  Column statusCard(BuildContext context, String roomname, String picturePath, String statusStr, Color statusColor, String reservationID, int capacity, String date, bool isDesktop) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 32 : 16),
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxWidth: isDesktop ? 800 : double.infinity,
            ),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Text(
                        'Status Peminjaman',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 81,
                        height: 18,
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(statusStr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 10, 147, 241),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: 
                          Image.network("$baseURL$picturePath",
                            headers: const {
                              "Content-Type": "application/json"
                            },
                            height: 75,
                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return const Icon(
                                Icons.broken_image,
                                color: Colors.red,
                                size: 75,
                              );
                            },
                          ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                roomname,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Kapasitas: $capacity',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Flexible(
                                child: Text(
                                  'Tanggal: $date',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 2,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ReservationDetailsPage(reservationID: reservationID,)),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 251, 188, 14),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          "Lihat detail peminjaman",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
