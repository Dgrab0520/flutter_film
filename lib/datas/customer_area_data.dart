import 'package:http/http.dart' as http;

class Area_Data{
  static const ROOT = 'http://gowjr0771.cafe24.com/customer_area.php';
  static const _ADD_AREA_ACTION = 'ADD_AREA';

  static Future<String> addArea(String user_id, String area) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] =_ADD_AREA_ACTION;
      map['user_id'] = user_id;
      map['area'] = area;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('addAreaw Response: ${response.body}');
      if(200 == response.body){
        return response.body;
      }else{
        return "error";
      }
    }catch(e){
      return "error";
    }
  }
}
