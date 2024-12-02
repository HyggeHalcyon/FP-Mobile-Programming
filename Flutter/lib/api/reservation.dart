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
}