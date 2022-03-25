import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/customerlist_model.dart';

class CustomerList_Data {
  static const ROOT = "http://211.110.1.58/film_customer_list.php";
  static const _GET_CUSTOMERLIST_ACTION = "GET_CUSTOMERLIST";

  static Future<List<Customer_List>> getCustomerList(
      String user_id, String status) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_CUSTOMERLIST_ACTION;
      map['user_id'] = user_id;
      map['status'] = status;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Get CustomerList Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Customer_List> list = parseResponse(response.body);
        return list;
      } else {
        return <Customer_List>[];
      }
    } catch (e) {
      return <Customer_List>[];
    }
  }

  static List<Customer_List> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Customer_List>((json) => Customer_List.fromJson(json))
        .toList();
  }
}
