import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/idpw_model.dart';

class SearchIDPW_Data{
  static const ROOT = "http://gowjr0771.cafe24.com/film_searchIDPW.php";
  static const _SEARCH_ID_ACTION = "SEARCH_ID";
  static const _SEARCH_PW_ACTION = "SEARCH_PW";

  static Future<List<SearchIDPW>> getSearchID(String user_ph) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _SEARCH_ID_ACTION;
      map['user_ph'] = user_ph;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Search Id Resposne : ${response.body}');
      if(200 == response.statusCode){
        List<SearchIDPW> list = parseResponse(response.body);
        return list;
      }else{
        return <SearchIDPW>[];
      }
    }catch(e){
      return <SearchIDPW>[];
    }
  }

  static Future<List<SearchIDPW>> getSearchPW(String user_id, String user_ph) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _SEARCH_PW_ACTION;
      map['user_id'] = user_id;
      map['user_ph'] = user_ph;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('search PW Response: ${response.body}');
      if(200 == response.statusCode){
        List<SearchIDPW> list = parseResponse(response.body);
        return list;
      }else{
        return <SearchIDPW>[];
      }
    }catch(e){
      return <SearchIDPW>[];
    }
  }

  static List<SearchIDPW> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<SearchIDPW>((json) => SearchIDPW.fromJson(json)).toList();
  }
}