import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pro_token_model.dart';

class ProToken_Data{
  static const ROOT = "http://gowjr0771.cafe24.com/pro_token_init.php";
  static const _GET_PRO_TOKEN = "PRO_TOKEN";

  static Future<List<ProToken>> getProToken(String area) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _GET_PRO_TOKEN;
      map['area'] = area;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Pro Token Response: ${response.body}');
      if(200 == response.statusCode){
        List<ProToken> list = parseResponse(response.body);
        return list;
      }else{
        return <ProToken>[];
      }
    }catch(e){
      return <ProToken>[];
    }
  }

  static List<ProToken> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<ProToken>((json) => ProToken.fromJson(json)).toList();
  }
}