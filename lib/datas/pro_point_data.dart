import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/pro_point_model.dart';

class ProPoint_Data{
  static const ROOT = 'http://gowjr0771.cafe24.com/film_pro_point.php';
  static const _GET_POINT_ACTION = 'GET_POINT';
  static const _GET_POINT_INFO_ACTION = 'GET_POINT_INFO';

  static Future<List<Pro_Point>> getProPoint(String user_id) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _GET_POINT_ACTION;
      map['user_id'] = user_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Pro Point Reseponse: ${response.body}');
      if(200 == response.statusCode){
        List<Pro_Point> list = parseResponse(response.body);
        return list;
      }else{
        return <Pro_Point>[];
      }
    }catch(e){
      return <Pro_Point>[];
    }
  }

  static Future<List<Pro_Point>> getProPointInfo(String user_id) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _GET_POINT_INFO_ACTION;
      map['user_id'] = user_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Pro Point Reseponse: ${response.body}');
      if(200 == response.statusCode){
        List<Pro_Point> list = parseResponse(response.body);
        return list;
      }else{
        return <Pro_Point>[];
      }
    }catch(e){
      return <Pro_Point>[];
    }
  }

  static List<Pro_Point> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Pro_Point>((json) => Pro_Point.fromJson(json)).toList();
  }
}