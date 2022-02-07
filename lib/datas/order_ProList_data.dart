import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order_ProList_model.dart';

class Order_ProList_Data{
  static const ROOT = "http://gowjr0771.cafe24.com/film_order_list.php";
  static const _GET_ORDER_LIST_ACTION = "GET_ORDER_LIST";

  static Future<List<Order_ProList>> getOrderProList(String order_id) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _GET_ORDER_LIST_ACTION;
      map['order_id'] = order_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Get Order_ProList Response: ${response.body}');
      if(200 == response.statusCode){
        List<Order_ProList> list = parseResponse(response.body);
        return list;
      }else{
        return <Order_ProList>[];
      }
    }catch(e){
      return <Order_ProList>[];
    }
  }


  static List<Order_ProList> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Order_ProList>((json) => Order_ProList.fromJson(json)).toList();
  }
}