import 'package:http/http.dart' as http;

class Update_ProProfile_Data {
  static const ROOT = "http://211.110.1.58/film_update_proProfile.php";
  static const UPDATE_INTRO_ACTION = "UPDATE_INTRO";
  static const UPDATE_BASIC_ACTION = "UPDATE_BASIC";
  static const UPDATE_COM_ACTION = "UPDATE_COM";

  static Future<String> updateProfile_Intro(
      String user_id, String introduce) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = UPDATE_INTRO_ACTION;
      map['user_id'] = user_id;
      map['introduce'] = introduce;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('update proProfile Intro Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> updateProfile_Basic(
      String user_id, String basic) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = UPDATE_BASIC_ACTION;
      map['user_id'] = user_id;
      map['basic'] = basic;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('update proProfile Basic Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> updateProfile_Com(
      String user_id, String company) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = UPDATE_COM_ACTION;
      map['user_id'] = user_id;
      map['company'] = company;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('update proProfile Company Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}
