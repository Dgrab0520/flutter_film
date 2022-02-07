import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/userCheck_model.dart';

class UserCheck_Data{
  static const ROOT = "http://gowjr0771.cafe24.com/film_userCheck.php";
  static const _GET_USER_CHECK = 'USER_CK';
  static const _GET_USER_ALL = 'USER_CK_ALL';

  static Future<List<User_Check>> getUserCheck(String user_id) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _GET_USER_CHECK;
      map['user_id'] = user_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getUser_Check Response: ${response.body}');
      if(200 == response.statusCode){
        List<User_Check> list = parseResponse(response.body);
        return list;
      }else{
        return <User_Check>[];
      }
    }catch (e){
      return <User_Check>[];
    }
  }


  static Future<List<User_Check>> getUserALL() async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _GET_USER_ALL;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getUser_ALL Response: ${response.body}');
      if(200 == response.statusCode){
        List<User_Check> list = parseResponse(response.body);
        return list;
      }else{
        return <User_Check>[];
      }
    }catch (e){
      return <User_Check>[];
    }
  }
  static List<User_Check> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User_Check>((json) => User_Check.fromJson(json)).toList();
  }
}