import 'package:http/http.dart' as http;

class Register_PointInfo{
  static const ROOT = "http://gowjr0771.cafe24.com/film_register_pointinfo.php";
  static const _ADD_POINITINFO_ACTION = "ADD_POINTINFO";

  static Future<String> addPointInfo(String user_id, String point_info, String point_detail) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _ADD_POINITINFO_ACTION;
      map['user_id'] = user_id;
      map['point_info'] = point_info;
      map['point_detail'] = point_detail;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('addPointInfo Response: ${response.body}');
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