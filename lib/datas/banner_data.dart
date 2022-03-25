import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/banner_model.dart';

class Banner_Data {
  static const ROOT = 'http://211.110.1.58/film_banner.php';
  static const _GET_BANNER_ACTION = 'GET_BANNER';

  static Future<List<Bbanner>> getBanner() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_BANNER_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getBanner Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Bbanner> list = parseResponse(response.body);
        return list;
      } else {
        return <Bbanner>[];
      }
    } catch (e) {
      return <Bbanner>[];
    }
  }

  static List<Bbanner> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Bbanner>((json) => Bbanner.fromJson(json)).toList();
  }
}
