import 'package:http/http.dart' as http;

class UpdateOrderStatus_Data{
  static const ROOT = 'http://gowjr0771.cafe24.com/film_update_orderStatus.php';
  static const _UPDATE_STATUS_ACTION = 'UPDATE_ORDER_SELECT';

  static Future<String> updateOrderStatus(String user_id, String order_date) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_STATUS_ACTION;
      map['user_id'] = user_id;
      map['order_date'] = order_date;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('update orderStatus Rseponse: ${response.body}');
      if(200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    }catch(e){
      return "error";
    }
  }
}