import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pro_profile_model.dart';


class ProProfile_Data{
  static const ROOT = "http://gowjr0771.cafe24.com/film_pro_profile.php";
  static const _GET_PRO_PROFILE = "PRO_PROFILE";

  static Future<List<Pro_Profile>> getProProfile(String user_id) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _GET_PRO_PROFILE;
      map['user_id'] = user_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Pro Profile Response: ${response.body}');
      if(200 == response.statusCode){
        List<Pro_Profile> list = parseResponse(response.body);
        return list;
      }else{
        return <Pro_Profile>[];
      }
    }catch(e){
      return <Pro_Profile>[];
    }
  }
  static List<Pro_Profile> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Pro_Profile>((json) => Pro_Profile.fromJson(json)).toList();
  }

}