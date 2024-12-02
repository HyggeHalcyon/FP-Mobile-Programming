import 'package:flutter/material.dart';
import 'package:its_rent_hub/api/api_globals.dart';

Positioned upperBar(context, isDesktop) {
  return Positioned(
    top: 0,
    left: 0,
    right: 0,
    child: Container(
      height: MediaQuery.of(context).size.height *
          0.28, // 26% of screen height
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
                            'Halo $name!',
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
                          Image.network('$baseURL$profilePicPath',
                            headers: {
                              "Authorization": "Bearer $token"
                            }
                          ).image,
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
  );
}