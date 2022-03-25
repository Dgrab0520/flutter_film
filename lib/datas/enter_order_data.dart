import 'package:http/http.dart' as http;

class Order_Data {
  static const ROOT = 'http://211.110.1.58/film_enter_order.php';
  static const _ADD_ORDER_ACTION = 'ADD_ORDER';

  static Future<String> addOrder(
      String user_id,
      String order_id,
      String service_date,
      String service_area,
      String service_type,
      String service_size,
      String service_detail,
      String order_type,
      String dir_pro_id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_ORDER_ACTION;
      map['user_id'] = user_id;
      map['order_id'] = order_id;
      map['service_date'] = service_date;
      map['service_area'] = service_area;
      map['service_type'] = service_type;
      map['service_size'] = service_size;
      map['service_detail'] = service_detail;
      map['order_type'] = order_type;
      map['dir_pro_id'] = dir_pro_id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('addOrder Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> sendAlimTalk(
    String user_id,
    String user_phone,
    String pro_phone,
    String pro_name,
    String content,
  ) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = "ADD_ALIMTALK";
      map['user_id'] = user_id;
      map['user_phone'] = user_phone;
      map['pro_phone'] = pro_phone;
      map['pro_name'] = pro_name;
      map['content'] = content;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Send AlimTalk Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}
