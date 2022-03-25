import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pro_profile_model.dart';

class ProProfile_Data {
  static const ROOT = "http://211.110.1.58/film_pro_profile.php";
  static const _GET_PRO_PROFILE = "PRO_PROFILE";

  static Future<List<Pro_Profile>> getProProfile(String user_id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_PRO_PROFILE;
      map['user_id'] = user_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Pro Profile Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Pro_Profile> list = parseResponse(response.body);
        return list;
      } else {
        return <Pro_Profile>[];
      }
    } catch (e) {
      return <Pro_Profile>[];
    }
  }

  static List<Pro_Profile> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Pro_Profile>((json) => Pro_Profile.fromJson(json))
        .toList();
  }

  static Future<List<String>> getProPhone(String user_id) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = "GET_PHONE";
      map['user_id'] = user_id;
      final response = await http
          .post(Uri.parse("http://211.110.1.58/film_pro_phone.php"), body: map);
      print('Pro Phone Response: ${response.body}');
      if (200 == response.statusCode) {
        String result = jsonDecode(response.body);
        return result.split("&&");
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
