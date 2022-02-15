import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_film/models/chat_model.dart';
import 'package:http/http.dart' as http;

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();
String getRandomString() => String.fromCharCodes(Iterable.generate(
    10, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class ChatData {
  static const ROOT = "http://gowjr0771.cafe24.com/film_chat.php";
  static const LIST_ACTION = "LIST";
  static const WRITE_ACTION = "WRITE";
  static const CHAT_LIST_ACTION = "CHAT_LIST";
  static const USER_CHAT_LIST_ACTION = "USER_CHAT_LIST";
  static const CUS_CHECK_ACTION = 'CUS_CHECK';
  static const ESTIMATE_CHAT_ACTION = 'ESTIMATE_CHAT';

  // //전문가일때 채팅목록 불러오기
  // static Future<List<ChatRoom>> getChatList(
  //     String proId, String serviceType) async {
  //   print(proId);
  //   try {
  //     var map = <String, dynamic>{};
  //     map['action'] = CHAT_LIST_ACTION;
  //     map['proId'] = proId;
  //     map['serviceType'] = serviceType;
  //     final response = await http.post(Uri.parse(ROOT), body: map);
  //     print('Chat List Response : ${response.body}');
  //
  //     if (response.statusCode == 200) {
  //       List<ChatRoom> list = chatRoomParseResponse(response.body);
  //       return list;
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     return [];
  //   }
  // }
  //
  // //고객일때 채팅목록 불러오기
  // static Future<List<UserChatRoom>> getUserChatList(String orderId) async {
  //   print(orderId);
  //   try {
  //     var map = <String, dynamic>{};
  //     map['action'] = USER_CHAT_LIST_ACTION;
  //     map['order_id'] = orderId;
  //     final response = await http.post(Uri.parse(ROOT), body: map);
  //     print('User Chat List Response : ${response.body}');
  //
  //     if (response.statusCode == 200) {
  //       List<UserChatRoom> list = userChatRoomParseResponse(response.body);
  //       return list;
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     return [];
  //   }
  // }
  //
  //채팅 불러오기
  static Future<List<Chat>> getChat(String estimateId) async {
    print("estimateId : $estimateId");
    try {
      var map = <String, dynamic>{};
      map['action'] = LIST_ACTION;
      map['estimateId'] = estimateId;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Chat Response : ${response.body}');

      if (response.statusCode == 200) {
        List<Chat> list = parseResponse(response.body);
        return list;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  //견적성 작성 후 채팅 입력
  static Future<String> inserChatting(String estimate_id, String estimate_detail) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = ESTIMATE_CHAT_ACTION;
      map['estimate_id'] = estimate_id;
      map['estimate_detail'] = estimate_detail;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Pro Chat Response: ${response.body}');
      if(200 == response.body){
        return response.body;
      }else{
        return "error";
      }
    }catch(e){
      return "error";
    }



  }
  //
  // //고객 채팅 여부 확인
  // static Future<List<Chat>> check_Cus(String estimateId) async {
  //   try {
  //     var map = Map<String, dynamic>();
  //     map['action'] = CUS_CHECK_ACTION;
  //     map['estimateId'] = estimateId;
  //     final response = await http.post(Uri.parse(ROOT), body: map);
  //     print("Customer Chat Response : ${response.body}");
  //     if (response.statusCode == 200) {
  //       List<Chat> list = parseResponse(response.body);
  //       return list;
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     return [];
  //   }
  // }

  //채팅쓰기
  static Future<List<String>> putChat(Chat chat, {File? file}) async {
    print(chat.text +
        "  " +
        chat.image +
        "  " +
        chat.isPro.toString() +
        "  " +
        chat.id.toString() +
        "  " +
        chat.estimateId.toString());
    String imageName = getRandomString() + ".gif";
    try {
      var url = Uri.parse(ROOT);
      var request = http.MultipartRequest('POST', url);
      request.fields['action'] = WRITE_ACTION;
      request.fields['estimateId'] = chat.estimateId.toString();
      request.fields['text'] = chat.text;
      request.fields['image'] = chat.image == "true" ? imageName : "";
      request.fields['isPro'] = chat.isPro.toString();
      if (file != null) {
        request.files
            .add(await http.MultipartFile.fromPath("chatImage", file.path));
      }
      http.Response response =
          await http.Response.fromStream(await request.send());
      print("Chatting Response : ${response.body}");
      if (response.statusCode == 200) {
        List<String> result = [response.body];
        if (file != null) result.add(imageName);
        return result;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static List<Chat> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Chat>((json) => Chat.fromJson(json)).toList();
  }

  // static List<ChatRoom> chatRoomParseResponse(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed.map<ChatRoom>((json) => ChatRoom.fromJson(json)).toList();
  // }
  //
  // static List<UserChatRoom> userChatRoomParseResponse(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed
  //       .map<UserChatRoom>((json) => UserChatRoom.fromJson(json))
  //       .toList();
  // }
}
