import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:its_rent_hub/api/api_globals.dart';
import 'package:its_rent_hub/models/auth.dart';

class AuthAPIService {
  Future<LoginResponse?> login(nrp, password) async {
    try {
      var url = Uri.parse('$baseAPIURL/user/login');
      var response = await http.post(url,
        headers: {
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "nrp": nrp,
          "password": password,
        })
      );

      LoginResponse res = authResponseFromJson(response.body);

      if (res.status == true && res.data != null && res.data?.token != '') {
        token = res.data?.token ?? '';
        await me();
      }


      return res;
    } catch (e) {
      isAuthenticed = false;
      print("Login: ${e.toString()}");
    }
    
    return null;
  }

  Future<MeResponse?> me() async {
    try {
      var url = Uri.parse('$baseAPIURL/user/me');
      var response = await http.get(url,
        headers: {
          "Authorization": "Bearer $token"
        }
      );

      MeResponse res = meResponseFromJson(response.body);
      if (res.status == true && res.data != null && res.data?.name != '') {
        isAuthenticed = true;
        profilePicPath = res.data?.profilePicture ?? '';
        name = res.data?.name ?? '';
      }

      return res;
    } catch (e) {
      isAuthenticed = false;
      print("Me ${e.toString()}");
    }
    
    return null;
  }
}