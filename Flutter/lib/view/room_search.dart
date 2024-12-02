import 'package:flutter/material.dart';
import 'package:its_rent_hub/api/api_globals.dart';
import 'package:its_rent_hub/api/room.dart';
import 'package:its_rent_hub/components/upperBar.dart';
import 'package:its_rent_hub/view/login.dart';
import 'package:its_rent_hub/view/room_details.dart';
import 'package:its_rent_hub/models/room.dart';

class RoomSearch extends StatefulWidget {
  const RoomSearch({super.key});

  @override
  _RoomSearchState createState() => _RoomSearchState();
}

class _RoomSearchState extends State<RoomSearch> {
  late List<RoomListData>? rooms = [];
  var isLoaded = false;

  @override
  void initState(){
    super.initState();
    _getData();
  }

  void _getData() async {
    RoomListResponse? response = await RoomAPIService().getAll();
    if (response != null) {
      setState(() {
        rooms = response.data;
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

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 800;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Room Search',
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
              if (!isLoaded)
                const Center(child: CircularProgressIndicator())
              else
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: isDesktop ? 280 : 200, bottom: 16), // Responsive
                    child: Column(
                      children: rooms!.map((room) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: RoomCard(
                            imagePath: "$baseURL${room.picture}",
                            roomName: room.name,
                            capacity: '${room.capacity} orang',
                            facilities: room.facilities,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RoomDetailsPage(roomID: room.id,),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              upperBar(context, isDesktop)
            ],
          ),
        );
      },
    );
  }
}

class RoomCard extends StatelessWidget {
  final String imagePath;
  final String roomName;
  final String capacity;
  final List<String> facilities;
  final VoidCallback onTap;

  const RoomCard({
    super.key,
    required this.imagePath,
    required this.roomName,
    required this.capacity,
    required this.facilities,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint("Navigating to RoomDetails for $roomName");
        onTap();
      },
      child: Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: Image.network(imagePath,
                    headers: {
                      "Authorization": "Bearer $token"
                    },
                  ).image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      roomName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text("Kapasitas : $capacity"),
                    const SizedBox(height: 4),
                    Text("Fasilitas: ${facilities.join(', ')}"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
