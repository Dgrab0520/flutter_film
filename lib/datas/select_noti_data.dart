import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/select_noti_model.dart';

class Noti_Select_Data{
  static const ROOT = "http://gowjr0771.cafe24.com/film_notice.php";
  static const _SELECT_NOTICE_ACTION = "NOTICE_SELECT";

  static Future<List<Select_Noti>> getNotiSelect() async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _SELECT_NOTICE_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Select_Noti : ${response.body}');
      if(200 == response.statusCode){
        List<Select_Noti> list = parseResponse(response.body);
        return list;
      }else{
        return <Select_Noti>[];
      }
    }catch(e){
      return <Select_Noti>[];
    }
  }
  static List<Select_Noti> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Select_Noti>((json) => Select_Noti.fromJson(json)).toList();
  }

}