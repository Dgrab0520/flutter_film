import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pro_select_model.dart';

class ProSelect_Data {
  static const ROOT = "http://211.110.1.58/pro_profile_select.php";
  static const _GET_PRO_SELECT = "PRO_SELECT";

  static Future<List<Pro_Select>> getProSelect(String user_id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_PRO_SELECT;
      map['user_id'] = user_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('ProSelect Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Pro_Select> list = parseResponse(response.body);
        return list;
      } else {
        return <Pro_Select>[];
      }
    } catch (e) {
      return <Pro_Select>[];
    }
  }

  static List<Pro_Select> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Pro_Select>((json) => Pro_Select.fromJson(json)).toList();
  }
}
