import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:its_rent_hub/api/auth.dart';
import 'package:its_rent_hub/models/auth.dart';
import 'package:its_rent_hub/view/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nrpForm = TextEditingController();
  final passwordForm = TextEditingController();

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    nrpForm.dispose();
    passwordForm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = MediaQuery.of(context).size.width;
              final isDesktop = constraints.maxWidth > 800;

              return Center(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        "Selamat Datang di",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Column(
                        children: [
                          Text(
                            "myITS",
                            style: TextStyle(
                              fontSize: 42,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "RentHub",
                            style: TextStyle(
                              fontSize: 23,
                              fontFamily: 'Poppins',
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
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? screenWidth * 0.2 : 20,
                        ),
                        child: Container(
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
                                    width: 100,
                                    height: 100,
                                  ),
                                  const Spacer(),
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "myITS",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Single sign-on",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w200,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              _buildTextField(label: "myITS ID", controller: nrpForm),
                              const SizedBox(height: 10),
                              _buildTextField(label: "Password", controller: passwordForm, isPassword: true),
                              const SizedBox(height: 20),
                              Container(
                                width: double.infinity,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xfffece3c),
                                      Color(0xffffb703)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () async {
                                    LoginResponse? response = await AuthAPIService().login(nrpForm.text, passwordForm.text);
                                    if (response == null) {
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

                                    if (response.status == true) {
                                      Fluttertoast.showToast(
                                        msg: 'Login Success',
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
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: response.error ?? 'Login Failed',
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        timeInSecForIosWeb: 2,
                                        webPosition: "center",
                                        webBgColor: "linear-gradient(to right, #dc1c13, #dc1c13)",
                                      );
                                    }

                                  },
                                  child: const Text(
                                    "Sign In",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
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
                                    Fluttertoast.showToast(
                                      msg: 'Not Implemented',
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      timeInSecForIosWeb: 2,
                                      webPosition: "center",
                                      webBgColor: "linear-gradient(to right, #dc1c13, #dc1c13)",
                                    );
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
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
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required TextEditingController controller, bool isPassword = false}) {
    return TextField(
      controller: controller,
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
