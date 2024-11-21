import 'package:flutter/material.dart';
import 'package:its_rent_hub/home.dart';

void main() {
  runApp(const LoginPage());
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Selamat Datang di",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 8),
                Column(
                  children: const [
                    Text(
                      "myITS",
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "RentHub",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "Pinjam Ruangan Jadi Makin Mudah!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20), // Outer padding
                  child: Container(
                    width: 325,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xff09a4f3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/logo_its.png",
                              width: 120,
                              height: 120,
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text(
                                  "myITS",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Single sign-on",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(label: "myITS ID"),
                        const SizedBox(height: 10),
                        _buildTextField(label: "Password", isPassword: true),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(
                              colors: [Color(0xfffece3c), Color(0xffffb703)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage1()),
                              );
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {
                              // Belom ada Forgot Password Page
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "EN",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: label,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Colors.black54,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
