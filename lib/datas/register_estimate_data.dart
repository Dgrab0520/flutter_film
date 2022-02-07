import 'package:http/http.dart' as http;

class RegisterEstimate_Data{
  static const ROOT = "http://gowjr0771.cafe24.com/registerEstimate.php";
  static const _ADD_ESTIMATE_ACTION = "ADD_ESTIMATE";

  static Future<String> addEstimate(String order_id, String estimate_id, user_id, pro_id, estimate_detail) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _ADD_ESTIMATE_ACTION;
      map['order_id'] = order_id;
      map['estimate_id'] = estimate_id;
      map['user_id'] = user_id;
      map['pro_id'] = pro_id;
      map['estimate_detail'] = estimate_detail;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('registerEstimate Response: ${response.body}');
      if('success' == response.body){
        return response.body;
      }else{
        return "error";
      }
    }catch(e){
      return "error";
    }
  }
}