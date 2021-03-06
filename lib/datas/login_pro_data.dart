import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

import '../models/userCheck_model.dart';

class Login_Data {
  static const ROOT = "http://211.110.1.58/film_login.php";
  static const _GET_LOGIN_ACTION = 'LOGIN';

  static Future<List<String>> getLogin(String user_id, String user_pw) async {
    setToken(String token) async {
      var url = Uri.parse('http://211.110.1.58/pro_token.php');
      var result = await http.post(url, body: {
        "token": token,
        "user_id": user_id,
      });
    } //토큰 저장

    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_LOGIN_ACTION;
      map['user_id'] = user_id;
      map['user_pw'] = user_pw;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getUser_Check Response: ${response.body}');
      if (response.statusCode == 200) {
        final body = json.decode(response.body).cast<Map<String, dynamic>>();

        print(body);
        print(body[0]['user_id']);
        //List<User_Check> list = parseResponse(response.body);
        FirebaseMessaging.instance
            .getToken()
            .then((value) => setToken(value!)); //로그인 성공시 토큰 값 얻기
        return [body[0]['user_id']];
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static List<User_Check> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User_Check>((json) => User_Check.fromJson(json)).toList();
  }
}
