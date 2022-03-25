import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_film/datas/enter_order_data.dart';
import 'package:flutter_film/datas/pro_profile_data.dart';
import 'package:flutter_film/datas/pro_token_data.dart';
import 'package:flutter_film/models/pro_token_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  DateTime _selectedDate = DateTime.now();
  final _valueList1 = ["선택", "아파트", "주택", "사무실", "상가", "기타"];
  final _valueList2 = ["선택", "제곱미터", "평형", "기타"];
  final _valueList3 = [
    "선택",
    "수도권",
    "부산",
    "대구",
    "광주",
    "대전",
    "울산",
    "세종",
    "강원",
    "경남",
    "경북",
    "전남",
    "전북",
    "충남",
    "충북",
    "제주"
  ];
  var _selectedValue1 = '선택';
  var _selectedValue2 = '선택';
  var _selectedValue3 = '선택';
  TextEditingController sizeController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  String? user_id = Get.parameters['id'];
  String? order_type = Get.parameters['type'];
  String? dir_pro_id = Get.parameters['dir_pro_id'];
  String? pro_token = Get.parameters['pro_token'];
  String? com_pro_id = 'None';
  String? user_token;
  List<ProToken>? _proToken;

  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('sendFCM',
      options: HttpsCallableOptions(timeout: const Duration(seconds: 5)));

  void sendFCM() async {
    List<String> tList = []; //메세지 보낼 사람 리스트
    String title = "[필름반장] 전문가님에게 견적요청이 도착했습니다";
    String body = "$user_id님이 견적을 요청했습니다. 견적을 확인해주세요";

    for (int i = 0; i < _proToken!.length; i++) {
      if (_proToken![i].pro_token != null) {
        tList.add(_proToken![i].pro_token);
        ProProfile_Data.getProPhone(_proToken![i].id).then((value) {
          if (value.isNotEmpty) {
            Order_Data.sendAlimTalk(user_id!, "", value[0], value[1],
                    "시공 희망 날짜 : ${_selectedDate.toLocal().toString().split(' ')[0]}\n작업 지역 : $_selectedValue3\n건물 형태 : $_selectedValue1\n면적 : ${sizeController.text + _selectedValue2}\n서비스 범위 : ${detailController.text}")
                .then((value2) {
              if (value2 != "error") {
                print("send AlimTalk $value");
              }
            });
          }
        });
      }
      print(tList);
    }
    final HttpsCallableResult result = await callable.call(
      <String, dynamic>{
        "token": tList,
        "title": title,
        "body": body,
      },
    ).whenComplete(() => Get.snackbar(
          '전송완료',
          '전문가에게 전송이 완료되었습니다',
        ));
    print(result.data);
  }

  void sendFCM_Dir() async {
    String title = "[필름반장] 전문가님에게 직접 견적요청이 도착했습니다";
    String body = "$user_id님이 견적을 요청했습니다. 견적을 확인해주세요";

    // for(int i = 0; i < _proToken!.length; i++){
    //   if(_proToken![i].pro_token != null){
    //     tList.add(_proToken![i].pro_token);
    //   }
    //   print(tList);
    // }
    final HttpsCallableResult result = await callable.call(
      <String, dynamic>{
        "token": pro_token,
        "title": title,
        "body": body,
      },
    ).whenComplete(() => Get.snackbar(
          '전송완료',
          '전문가에게 전송이 완료되었습니다',
        ));
    print(result.data);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  _getProToken() {
    ProToken_Data.getProToken(_selectedValue3).then((proToken) {
      setState(() {
        _proToken = proToken;
      });
    });
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2021),
        lastDate: DateTime(2999));
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  //OrderId Random 생성
  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  _addOrder() {
    if (order_type == "com") {
      Order_Data.addOrder(
        user_id!,
        generateRandomString(12),
        _selectedDate.toLocal().toString().split(' ')[0],
        _selectedValue3,
        _selectedValue1,
        sizeController.text + _selectedValue2,
        detailController.text,
        order_type!,
        com_pro_id!,
      ).then((result) {
        if (result == 'success') {
          print("success");
          FirebaseMessaging.instance
              .getToken()
              .then((value) => setToken(value!));
          sendFCM();

          Get.offNamed('/customerList/true?id=$user_id');
        } else {
          print("error");
          Get.snackbar("ERROR", "네트워크 상태를 확인하세요");
        }
      });
    } else {
      Order_Data.addOrder(
        user_id!,
        generateRandomString(12),
        _selectedDate.toLocal().toString().split(' ')[0],
        _selectedValue3,
        _selectedValue1,
        sizeController.text + _selectedValue2,
        detailController.text,
        order_type!,
        dir_pro_id!,
      ).then((result) {
        if (result == 'success') {
          print("success");
          FirebaseMessaging.instance
              .getToken()
              .then((value) => setToken(value!)); //로그인 성공시 토큰 값 얻기
          sendFCM_Dir();
          Get.offNamed('/customerList/true?id=$user_id');
        } else {
          print("error");
          Get.snackbar("ERROR", "네트워크 상태를 확인하세요");
        }
      });
    }
  }

  setToken(String token) async {
    var url = Uri.parse('http://211.110.1.58/user_token.php');
    var result = await http.post(url, body: {
      "token": token,
      "user_id": user_id,
    });
  } //토큰 저장

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          '견적신청',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                color: Color(0xFFF0F0F0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 3.0, color: Color(0xFF398FE2)),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text('시공 희망 날짜')
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 45.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(width: 0.5, color: Color(0xFF636363)),
                          borderRadius: BorderRadius.circular(3.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            '${_selectedDate.toLocal()}'.split(' ')[0],
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Spacer(),
                          IconButton(
                              icon: Icon(Icons.calendar_today_outlined),
                              onPressed: () {
                                _selectDate(context);
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  color: Color(0xFFF0F0F0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 3.0, color: Color(0xFF398FE2)),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('작업 지역')
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          height: 45.0,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 0.5, color: Color(0xFF636363)),
                              borderRadius: BorderRadius.circular(3.0)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedValue3,
                              items: _valueList3.map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue3 = value!;
                                  _getProToken();
                                  print("prprprprp $_proToken");
                                });
                              },
                            ),
                          ))
                    ],
                  )),
              SizedBox(
                height: 10.0,
              ),
              Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  color: Color(0xFFF0F0F0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 3.0, color: Color(0xFF398FE2)),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          const Text('건물 형태')
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          height: 45.0,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  width: 0.5, color: Color(0xFF636363)),
                              borderRadius: BorderRadius.circular(3.0)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedValue1,
                              items: _valueList1.map((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue1 = value!;
                                });
                              },
                            ),
                          ))
                    ],
                  )),
              SizedBox(
                height: 10.0,
              ),
              Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  color: Color(0xFFF0F0F0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 3.0, color: Color(0xFF398FE2)),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('면적')
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 45.0,
                                child: TextField(
                                  controller: sizeController,
                                  cursorHeight: 20.0,
                                  style: TextStyle(fontSize: 13.0, height: 1.0),
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: '숫자를 입력하세요',
                                    labelStyle: TextStyle(fontSize: 11.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xFF636363), width: 0.5),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 0.5)),
                                  ),
                                ),
                              )),
                          SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                height: 45.0,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 0.5, color: Color(0xFF636363)),
                                    borderRadius: BorderRadius.circular(3.0)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedValue2,
                                    items: _valueList2.map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedValue2 = value!;
                                      });
                                    },
                                  ),
                                )),
                          ),
                        ],
                      )
                    ],
                  )),
              SizedBox(
                height: 10.0,
              ),
              Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  color: Color(0xFFF0F0F0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 3.0, color: Color(0xFF398FE2)),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('서비스 범위')
                        ],
                      ),
                      Text(
                        '서비스를 희망하는 내용을 작성해주세요',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w200,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        height: 100.0,
                        child: TextField(
                          controller: detailController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          cursorHeight: 20.0,
                          style: TextStyle(
                              fontSize: 13.0, height: 1.0, color: Colors.black),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText:
                                '1. 도어(방문 / 욕실 / 창고)\n2. 샤시창(거실 / 안방 / 작은방 / 기타)\n3. 몰딩(가구 / 기타)\n4. 싱크대(싱크대 상하부장, 냉장고 장, 기타)\n',
                            hintStyle: TextStyle(fontSize: 11.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF636363), width: 0.5),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 0.5)),
                          ),
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  child: Text(
                    '신청하기',
                    style:
                        TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(primary: Color(0xFF398FE2)),
                  onPressed: () {
                    print('신청하기');
                    if (_selectedValue1 != '선택' ||
                        _selectedValue2 != '선택' ||
                        _selectedValue3 != '선택') {
                      _addOrder();
                    } else {
                      Get.snackbar('Error', '입력이 완료되지 않았습니다');
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    Order_Data.sendAlimTalk(
                            user_id!,
                            "",
                            "01044785303",
                            "디그랩(D-Grab)",
                            "시공 희망 날짜 : ${_selectedDate.toLocal().toString().split(' ')[0]}\n작업 지역 : $_selectedValue3\n건물 형태 : $_selectedValue1\n면적 : ${sizeController.text + _selectedValue2}\n서비스 범위 : ${detailController.text}")
                        .then((value2) {
                      if (value2 != "error") {
                        print("send AlimTalk");
                      }
                    });
                  },
                  child: Text("테스트")),
            ],
          ),
        ),
      ),
    );
  }
}
