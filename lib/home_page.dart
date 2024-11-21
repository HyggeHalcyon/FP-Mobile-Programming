import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        toolbarHeight:
            MediaQuery.of(context).size.height * 0.15, // Tinggi responsif
        title: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = MediaQuery.of(context).size.width;
            final isDesktop = screenWidth > 800; // Deteksi desktop atau mobile

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Kolom Teks Selamat Datang
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Halo!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isDesktop ? 28 : 20, // Responsif
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis, // Hindari overflow
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Bagaimana kabarmu hari ini?',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: isDesktop ? 16 : 14, // Responsif
                        ),
                        overflow: TextOverflow.ellipsis, // Hindari overflow
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10), // Jarak antara teks dan avatar
                // Avatar Profil
                CircleAvatar(
                  radius: isDesktop ? 30 : 20, // Ukuran responsif
                  backgroundColor: Colors.white,
                  backgroundImage:
                      const AssetImage('assets/profile.jpg'), // Gambar profil
                ),
              ],
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari ruangan kamu',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Card List
            Expanded(
              child: ListView(
                children: [
                  buildRoomCard(
                    status: 'Diterima',
                    color: Colors.green,
                    room: 'TW-502',
                    capacity: '60',
                    date: '24 November 2024',
                  ),
                  buildRoomCard(
                    status: 'Selesai',
                    color: Colors.blue,
                    room: 'TW-501',
                    capacity: '60',
                    date: '30 Oktober 2024',
                  ),
                  buildRoomCard(
                    status: 'Ditolak',
                    color: Colors.red,
                    room: 'TW-401',
                    capacity: '60',
                    date: '30 Oktober 2024',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aksi tombol tambah
        },
        backgroundColor: Colors.yellow,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget buildRoomCard({
    required String status,
    required Color color,
    required String room,
    required String capacity,
    required String date,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isDesktop = screenWidth > 800; // Desktop jika lebih dari 800px

        // Batasi lebar kartu di desktop
        final maxCardWidth = isDesktop ? 600.0 : screenWidth;

        return Center(
          child: Container(
            width: maxCardWidth,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.all(screenWidth * 0.03),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Baris Atas: Gambar dan Detail
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gambar Ruangan
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/room.jpg', // Gambar ruangan
                        height: screenWidth * 0.2, // Responsif
                        width: screenWidth * 0.2, // Responsif
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04), // Jarak antara elemen
                    // Informasi Detail
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            room,
                            style: TextStyle(
                              fontSize: isDesktop ? 20 : 16, // Responsif
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Kapasitas: $capacity',
                            style: TextStyle(
                              fontSize: isDesktop ? 16 : 14, // Responsif
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            'Tanggal: $date',
                            style: TextStyle(
                              fontSize: isDesktop ? 16 : 14, // Responsif
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenWidth * 0.03), // Spasi antara bagian
                // Baris Bawah: Status dan Tombol
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Status
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenWidth * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isDesktop ? 14 : 12, // Responsif
                        ),
                      ),
                    ),
                    // Tombol Lihat Detail
                    TextButton(
                      onPressed: () {
                        // Aksi tombol
                      },
                      child: Text(
                        'Lihat detail peminjaman',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: isDesktop ? 14 : 12, // Responsif
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
