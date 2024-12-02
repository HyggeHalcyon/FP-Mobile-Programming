import 'package:its_rent_hub/view/login.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDesktop = screenWidth > 800; // Cek jika layar besar (desktop)

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? screenWidth * 0.25 : screenWidth * 0.1,
            ), // Tambahkan padding besar
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon atau Logo
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.yellow.withOpacity(0.5),
                        blurRadius: 50,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/logo.png', // Ganti dengan path logo Anda
                    height: isDesktop
                        ? screenHeight * 0.3
                        : screenHeight * 0.2, // Responsif
                    width: isDesktop
                        ? screenHeight * 0.3
                        : screenHeight * 0.2, // Responsif
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // Teks Judul
                Text(
                  'myITS RentHub',
                  style: TextStyle(
                    fontSize: isDesktop ? 32 : 24, // Responsif
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                // Teks Deskripsi
                Text(
                  'Aplikasi peminjaman ruangan\n'
                  'di ITS guna memudahkan civitas akademika ITS.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isDesktop ? 20 : 16, // Responsif
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                // Tombol Start
                ElevatedButton(
                  onPressed: () {
                    // Aksi tombol
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey, // Warna tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          isDesktop ? screenWidth * 0.1 : screenWidth * 0.15,
                      vertical: screenHeight * 0.02,
                    ),
                  ),
                  child: Text(
                    'START',
                    style: TextStyle(
                      fontSize: isDesktop ? 20 : 18, // Responsif
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
