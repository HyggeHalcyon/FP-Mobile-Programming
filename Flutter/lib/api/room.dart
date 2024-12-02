import 'package:http/http.dart' as http;
import 'package:its_rent_hub/api/api_globals.dart';
import 'package:its_rent_hub/models/room.dart';

class RoomAPIService {
  Future<RoomListResponse?> getAll() async {
    try {
      var url = Uri.parse('$baseAPIURL/room');
      var response = await http.get(url,
        headers: {
          "Authorization": "Bearer $token"
        }
      );

      RoomListResponse res = roomListResponseFromJson(response.body);
      return res;
    } catch(e) {
      print("ROOM ALL: ${e.toString()}");
    }
    
    return null;
  }

  Future<RoomDetailsReponse?> getDetails(id) async {
    try {
      var url = Uri.parse('$baseAPIURL/room/$id');
      var response = await http.get(url,
        headers: {
          "Authorization": "Bearer $token"
        }
      );

      RoomDetailsReponse res = roomDetailsResponseFromJson(response.body);
      return res;
    } catch(e) {
      print("ROOM DETAILS: ${e.toString()}");
    }

    return null;
  }
}
