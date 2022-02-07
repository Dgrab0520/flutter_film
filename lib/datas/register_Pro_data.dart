import 'package:http/http.dart' as http;

class ProUser_Data{
  static const ROOT = "http://gowjr0771.cafe24.com/prousers_register.php";
  static const _ADD_PRO_ACTION = 'ADD_RRO';

  static Future<String> addProUser(String user_id, String user_pw, String skill, String user_email, String phone_number, String com_name, String com_no, String area1, String area2, String area3) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _ADD_PRO_ACTION;
      map['user_id'] = user_id;
      map['user_pw'] = user_pw;
      map['skill'] = skill;
      map['user_email'] = user_email;
      map['phone_number'] = phone_number;
      map['com_name'] = com_name;
      map['com_no'] = com_no;
      map['area1'] = area1;
      map['area2'] = area2;
      map['area3'] = area3;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('addProuser Response: ${response.body}');
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