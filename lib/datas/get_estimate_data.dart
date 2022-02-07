import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/get_estimate_model.dart';

class Estimate_Info_Data{
  static const ROOT = "http://gowjr0771.cafe24.com/film_estimate_info.php";
  static const _GET_ESTIMATE_ACTION = "GET_ESTIMATE";

  static Future<List<Estimate_Info>> getEstimateInfo(String pro_id) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _GET_ESTIMATE_ACTION;
      map['pro_id'] = pro_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("Get EstimateInfo Response: ${response.body}");
      if(200 == response.statusCode){
        List<Estimate_Info> list = parseResponse(response.body);
        return list;
      }else{
        return <Estimate_Info>[];
      }
    }catch(e){
      return <Estimate_Info>[];
    }
  }

  static List<Estimate_Info> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Estimate_Info>((json) => Estimate_Info.fromJson(json)).toList();
  }
}