import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/select_order_model.dart';

class Order_Select_Data {
  static const ROOT = "http://211.110.1.58/film_order_select.php";
  static const _SELECT_ORDER_ACTION = "ORDER_SELECT";
  static const _SELECT_DIR_ACTION = "ORDER_DIRSELECT";
  static const GET_ORDER_ACTION = "GET_ORDER";

  static Future<List<Select_Order>> getOrderSelect(String user_id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _SELECT_ORDER_ACTION;
      map['user_id'] = user_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Select_Order: ${response.body}');
      if (200 == response.statusCode) {
        List<Select_Order> list = parseResponse(response.body);
        return list;
      } else {
        return <Select_Order>[];
      }
    } catch (e) {
      return <Select_Order>[];
    }
  }

  static Future<List<Select_Order>> getDirOrderSelect(String user_id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _SELECT_DIR_ACTION;
      map['user_id'] = user_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Select_DirOrder: ${response.body}');
      if (200 == response.statusCode) {
        List<Select_Order> list = parseResponse(response.body);
        return list;
      } else {
        return <Select_Order>[];
      }
    } catch (e) {
      return <Select_Order>[];
    }
  }

  static Future<List<Select_Order>> getOrder(String order_id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = GET_ORDER_ACTION;
      map['order_id'] = order_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print("Select Order Response : ${response.body}");
      if (200 == response.statusCode) {
        List<Select_Order> list = parseResponse(response.body);
        return list;
      } else {
        return <Select_Order>[];
      }
    } catch (e) {
      return <Select_Order>[];
    }
  }

  static List<Select_Order> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Select_Order>((json) => Select_Order.fromJosn(json))
        .toList();
  }
}
