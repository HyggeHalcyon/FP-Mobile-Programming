import 'package:flutter/material.dart';

class FormCreatePage extends StatelessWidget {
  const FormCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 800;

        return Scaffold(
          appBar: AppBar(
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
                    const SizedBox(height: 200), // Tinggi header baru
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Konten setelah header
                          RoomCard(
                            imagePath: 'assets/tw302.jpg',
                            roomName: "TW-302 (Tower 1 ITS)",
                            capacity: "60 orang",
                            facilities: "Microphone, Speaker, LCD Projector",
                            onTap: () {
                              Navigator.pushNamed(context, '/roomDetails');
                            },
                          ),
                          RoomCard(
                            imagePath: 'assets/tw502.jpg',
                            roomName: "TW-502 (Tower 1 ITS)",
                            capacity: "60 orang",
                            facilities: "Microphone, Speaker, LCD Projector",
                            onTap: () {
                              Navigator.pushNamed(context, '/roomDetails');
                            },
                          ),
                          RoomCard(
                            imagePath: 'assets/tw603.jpg',
                            roomName: "TW-603 (Tower 1 ITS)",
                            capacity: "60 orang",
                            facilities: "Microphone, Speaker, LCD Projector",
                            onTap: () {
                              Navigator.pushNamed(context, '/roomDetails');
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: isDesktop ? 280 : 200,
                  width: double.infinity,
                  decoration: const ShapeDecoration(
                    color: Color.fromARGB(255, 10, 147, 241),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(43),
                        bottomRight: Radius.circular(43),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 100 : 16,
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double screenWidth = constraints.maxWidth;
                        bool isSmallScreen = screenWidth < 600;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Greeting Text
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Halo!',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: isSmallScreen ? 20 : 28,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Bagaimana kabarmu hari ini?',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: isSmallScreen ? 16 : 20,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                    width: 10), // Space between text and avatar
                                // Avatar
                                CircleAvatar(
                                  radius: isSmallScreen
                                      ? 20
                                      : 30, // Responsive size
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      const AssetImage('assets/profile.jpg'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Search Bar
                            Container(
                              width: double.infinity,
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Cari ruangan kamu',
                                        hintStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: isSmallScreen ? 14 : 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
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
  final String facilities;
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
      onTap: onTap,
      child: Card(
        color: Colors.white, // Make the card white
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
                  image: AssetImage(imagePath),
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
                    Text("Fasilitas: $facilities"),
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
