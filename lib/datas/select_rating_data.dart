import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/select_rating_model.dart';

class SelectRating_Data {
  static const ROOT = "http://211.110.1.58/film_select_rating.php";
  static const _GET_RATING_ACTION = "GET_RATING";

  static Future<List<Select_Rating>> getRating(String pro_id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_RATING_ACTION;
      map['pro_id'] = pro_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      var values = response.body;
      print("Select Rating Response: $values");

      if (200 == response.statusCode) {
        List<Select_Rating> list = parseResponse(response.body);
        return list;
      } else {
        return <Select_Rating>[];
      }
    } catch (e) {
      return <Select_Rating>[];
    }
  }

  static List<Select_Rating> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Select_Rating>((json) => Select_Rating.fromJson(json))
        .toList();
  }
}
