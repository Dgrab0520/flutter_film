import 'package:http/http.dart' as http;

class RegisterProfile_Data {
  static const ROOT = "http://211.110.1.58/registerProfile.php";
  static const _ADD_PROFILE_ACTION = 'ADD_PROFILE';

  static Future<String> addProfile(
      String user_id, String introduce, String basic, String company) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_PROFILE_ACTION;
      map['user_id'] = user_id;
      map['introduce'] = introduce;
      map['basic'] = basic;
      map['company'] = company;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('registerProfile Response: ${response.body}');
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
