import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/ad_model.dart';

class Ad_Data {
  static const ROOT = 'http://211.110.1.58/film_ad.php';
  static const _GET_AD_ACTION = 'GET_AD';
  static const _GET_AD_ACTION2 = 'GET_AD2';

  static Future<List<Ad>> getAd() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_AD_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getAD Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Ad> list = parseResponse(response.body);
        return list;
      } else {
        return <Ad>[];
      }
    } catch (e) {
      return <Ad>[];
    }
  }

  static Future<List<Ad>> getAd2(String ad_id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_AD_ACTION2;
      map['ad_id'] = ad_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getAD Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Ad> list = parseResponse(response.body);
        return list;
      } else {
        return <Ad>[];
      }
    } catch (e) {
      return <Ad>[];
    }
  }

  static List<Ad> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Ad>((json) => Ad.fromJson(json)).toList();
  }
}
