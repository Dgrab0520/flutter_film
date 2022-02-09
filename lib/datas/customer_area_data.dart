import 'package:http/http.dart' as http;

class Area_Data {
  static const ROOT = 'http://gowjr0771.cafe24.com/customer_area.php';
  static const _ADD_AREA_ACTION = 'ADD_AREA';
  static const _UPDATE_TOKEN_ACTION = 'UPDATE_TOKEN';

  static Future<String> addArea(String user_id, String area) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_AREA_ACTION;
      map['user_id'] = user_id;
      map['area'] = area;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('addArea Response: ${response.body}');
      if (200 == response.body) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> updateToken(String user_id, String token) async {
    print(user_id);
    print(token);
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_TOKEN_ACTION;
      map['user_id'] = user_id;
      map['token'] = token;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Update Token Response: ${response.body}');
      if (200 == response.body) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}
