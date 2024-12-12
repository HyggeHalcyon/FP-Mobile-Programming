import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:its_rent_hub/api/reservation.dart';
import 'package:its_rent_hub/models/reservation.dart';

Card availibilityBox(roomID, TextEditingController cStartDate, TextEditingController cEndDate, TextEditingController cStartTime, TextEditingController cEndTime) {
  return Card(
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
          const Text(
            "Tanggal Mulai",
            style: TextStyle(
              fontFamily: 'Poppins'
            ),
          ),
          Row(
            children: [
              const Icon(Icons.calendar_today),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: cStartDate,
                  decoration: InputDecoration(
                    hintText: "YYYY-MM-DD",
                    hintStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
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
                  controller: cStartTime,
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
          const Text(
            "Hingga Tanggal",
            style: TextStyle(
              fontFamily: 'Poppins'
            ),
          ),
          Row(
            children: [
              const Icon(Icons.calendar_today),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: cEndDate,
                  decoration: InputDecoration(
                    hintText: "YYYY-MM-DD",
                    hintStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
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
                  controller: cEndTime,
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
          Center(
            child: ElevatedButton(
              onPressed: () async {
                String start = '${cStartDate.text} ${cStartTime.text}';
                String end = '${cEndDate.text} ${cEndTime.text}';
                CheckReservationResponse? res = await ReservationAPIService().checkAvailbility(roomID, start, end);
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

                if (res.data?.available ?? false) {
                  Fluttertoast.showToast(
                    msg: 'Unavailable',
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
                  msg: 'Available',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  timeInSecForIosWeb: 2,
                  webPosition: "center",
                  webBgColor: "linear-gradient(to right, #19C63C, #19C63C)",
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                "Cek",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}