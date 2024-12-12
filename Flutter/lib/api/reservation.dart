import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:its_rent_hub/api/api_globals.dart';
import 'package:its_rent_hub/models/reservation.dart';

class ReservationAPIService {
  Future<MyReservationResponse?> myReservations() async {
    try {
      var url = Uri.parse('$baseAPIURL/reservation');
      var response = await http.get(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        }
      );

      MyReservationResponse res = myReservationResponseFromJson(response.body);
      return res;
    } catch(e) {
      print("MyReservations: ${e.toString()}");
    }

    return null;
  }

  Future<ReservationDetailsResponse?> reservationDetails(id) async {
    try {
      var url = Uri.parse('$baseAPIURL/reservation/$id');
      var response = await http.get(url,
        headers: {
          "Authorization": "Bearer $token"
        });
      
      ReservationDetailsResponse res = reservationDetailsFromJson(response.body);
      return res;
    } catch(e) {
      print("ReservationDetails: ${e.toString()}");
    }

    return null;
  }

  Future<DeleteReservationResponse?> deleteReservation(id) async {
    try {
      var url = Uri.parse('${baseAPIURL}/reservation/$id');
      var response = await http.delete(url,
      headers: {
          "Authorization": "Bearer $token"
      });

      DeleteReservationResponse res = deleteReservationResponseFromJson(response.body);
      return res;
    } catch(e) {
      print("deleteReservation: ${e.toString()}");
    }
    
    return null;
  }

  Future<ReservationDetailsResponse?> createReservation(roomID, start, end) async {
    try {
      var url = Uri.parse('${baseAPIURL}/reservation');
      var response = await http.post(url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "id": roomID,
          "start_date": start,
          "end_date": end
        })
      );

      ReservationDetailsResponse res = reservationDetailsFromJson(response.body);
      return res;
    } catch(e) { 
      print("createReservation: ${e.toString()}");
    }

    return null;
  }

    Future<ReservationDetailsResponse?> updateReservation(roomID, start, end) async {
    try {
      var url = Uri.parse('${baseAPIURL}/reservation');
      var response = await http.patch(url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "id": roomID,
          "start_date": start,
          "end_date": end
        })
      );

      ReservationDetailsResponse res = reservationDetailsFromJson(response.body);
      return res;
    } catch(e) { 
      print("updateReservation: ${e.toString()}");
    }

    return null;
  }

  Future<CheckReservationResponse?> checkAvailbility(roomID, start, end) async {
    try {
      var url = Uri.parse('${baseAPIURL}/reservation/check');
      var response = await http.post(url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "id": roomID,
          "start_date": start,
          "end_date": end
        })
      );

      CheckReservationResponse res = checkReservationResponseFromJson(response.body);
      return res;
    } catch(e) { 
      print("checkAvailbility: ${e.toString()}");
    }

    return null;
  }
}