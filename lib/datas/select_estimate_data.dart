import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/select_estimate_model.dart';

List<Select_Estimate> estimate = [];

class Estimate_Select_Data {
  static const ROOT = 'http://gowjr0771.cafe24.com/film_estimate_select.php';
  static const _SELECT_ESTIMATE_ACTION = 'ESTIMATE_SELECT';
  static const _SELECT_ESTIMATE_CHECK = "ESTIMATE_CHECK";
  static const _SELECT_PRO_ACTION = "SELECT_PRO";
  static const _SELECT_USER_ACTION = "SELECT_USER";
  static const _SELECT_CHAT_ACTION = "SELECT_CHAT";

  static Future<List<Select_Estimate>> getEstimateSelect(
      String order_id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _SELECT_ESTIMATE_ACTION;
      map['order_id'] = order_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('SelectEstimate Respose: ${response.body}');
      if (200 == response.statusCode) {
        List<Select_Estimate> list = parseResponse(response.body);
        return list;
      } else {
        return <Select_Estimate>[];
      }
    } catch (e) {
      return <Select_Estimate>[];
    }
  }

  static Future<List<Select_Estimate>> getChatEstimate(
      String estimate_id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _SELECT_CHAT_ACTION;
      map['estimate_id'] = estimate_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Select Chat Estimate Respose: ${response.body}');
      if (200 == response.statusCode) {
        List<Select_Estimate> list = parseResponse(response.body);
        return list;
      } else {
        return <Select_Estimate>[];
      }
    } catch (e) {
      return <Select_Estimate>[];
    }
  }

  static Future<List<Select_Estimate>> getProEstimate(String pro_id) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _SELECT_PRO_ACTION;
      map['pro_id'] = pro_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      ;
      print('Select Pro Estimate Response : ${response.body}');
      if (200 == response.statusCode) {
        List<Select_Estimate> list = parseResponse(response.body);
        return list;
      } else {
        return <Select_Estimate>[];
      }
    } catch (e) {
      return <Select_Estimate>[];
    }
  }

  static Future<List<Select_Estimate>> getUserEstimate(String user_id) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _SELECT_USER_ACTION;
      map['user_id'] = user_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      ;
      print('Select User Estimate Response : ${response.body}');
      if (200 == response.statusCode) {
        List<Select_Estimate> list = parseResponse(response.body);
        return list;
      } else {
        return <Select_Estimate>[];
      }
    } catch (e) {
      return <Select_Estimate>[];
    }
  }

  static Future<List<Select_Estimate>> getEstimateCheck(
      String order_id, pro_id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _SELECT_ESTIMATE_CHECK;
      map['order_id'] = order_id;
      map['pro_id'] = pro_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('CheckEstimate Respose: ${response.body}');
      if (200 == response.statusCode) {
        List<Select_Estimate> list = parseResponse(response.body);
        return list;
      } else {
        return <Select_Estimate>[];
      }
    } catch (e) {
      return <Select_Estimate>[];
    }
  }

  static List<Select_Estimate> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Select_Estimate>((json) => Select_Estimate.fromJson(json))
        .toList();
  }
}
