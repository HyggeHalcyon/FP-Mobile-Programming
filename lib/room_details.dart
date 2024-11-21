import 'package:flutter/material.dart';
import 'package:its_rent_hub/home.dart';

class RoomDetailsPage extends StatelessWidget {
  const RoomDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
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
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Cek Ketersediaan",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Tanggal Mulai (DD/MM/YYYY)",
                                    hintStyle: const TextStyle(
                                      fontFamily: 'Poppins',
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "HH:MM",
                                    hintStyle: const TextStyle(
                                      fontFamily: 'Poppins',
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Hingga Tanggal (DD/MM/YYYY)",
                                    hintStyle: const TextStyle(
                                      fontFamily: 'Poppins',
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "HH:MM",
                                    hintStyle: const TextStyle(
                                      fontFamily: 'Poppins',
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Aksi tombol
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage1()),
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
