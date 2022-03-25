import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_film/datas/register_estimate_data.dart';
import 'package:flutter_film/datas/userCheck_data.dart';
import 'package:flutter_film/models/userCheck_model.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SmsPage extends StatefulWidget {
  @override
  _SmsPageState createState() => _SmsPageState();
}

class _SmsPageState extends State<SmsPage> {
  bool? _isLoading;
  bool? _isChecked = false;
  bool? _isAgree = false;
  List<User_Check>? _user_info;
  String? pro_id;
  String? user_id;
  String? estimate_id;
  String? com_name;
  String? token;

  //telephony
  String _message = "";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    pro_id = Get.parameters['id'];
    user_id = Get.parameters['user_id'];
    estimate_id = Get.parameters['estimate_id'];
    com_name = Get.parameters['com_name'];
    token = Get.parameters['token'];
    print(estimate_id);
    _isLoading = false;
    _user_info = [];
    _getUserInfo();
  }

  _getUserInfo() {
    UserCheck_Data.getUserCheck(pro_id!).then((user_info) {
      setState(() {
        _user_info = user_info;
      });
      if (user_info.isEmpty) {
        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = true;
        });
      }
    });
  }

  _textMe() async {
    if (Platform.isAndroid) {
      dynamic uri =
          'sms:+82 ${_user_info![0].phone_number}?body=[필름반장]\n${user_id!.substring(0, 5)}****님이 시공전문가님에게 작업 의뢰를 요청하였습니다.\nSMS를 통해 자세한 상담을 진행해주세요.';
      await launch(uri);
    } else if (Platform.isIOS) {
      // iOS
      dynamic uri =
          'sms:0082-${_user_info![0].phone_number}&body=[필름반장]\n${user_id!.substring(0, 5)}****님이 시공전문가님에게 작업 의뢰를 요청하였습니다.\nSMS를 통해 자세한 상담을 진행해주세요.';
      await launch(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            '의뢰하기',
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
              Get.back();
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "'자세한 견적은 해당 전문가와 SMS 상담을 통해 진행할 수 있습니다'",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                    width: Get.width,
                    height: Get.height * 0.6,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5),
                    ),
                    child: Column(
                      children: <Widget>[
                        Text('- 개인정보 이용약관 [필수]',
                            style: TextStyle(
                                fontSize: 13.0, color: Colors.redAccent)),
                        Container(
                          width: Get.width,
                          child: Text(
                            '\n\n제 1조(개인정보의 처리 목적)\n\n<공간인테리어>은(는) 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용로로는 이용되지 않으며 이용 목적이 변경되는 경우 [개인정보 보호법] 재 18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.\n\n1. 홈페이지 회원 강비 및 관리\n\n회원 가입의사 확인 목적으로 개인정보를 처리합니다.',
                            softWrap: true,
                            maxLines: 20,
                            overflow: TextOverflow.ellipsis,
                            style:
                                TextStyle(fontSize: 11.0, color: Colors.grey),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              launch('https://211.110.1.58/privacy.html',
                                  forceWebView: true);
                            },
                            child: Text('자세히 보기')),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Checkbox(
                                value: _isAgree,
                                onChanged: (value) {
                                  setState(() {
                                    _isAgree = value;
                                    _isChecked = false;
                                  });
                                }),
                            Text('동의함'),
                            SizedBox(
                              width: 30.0,
                            ),
                            Checkbox(
                                value: _isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    _isChecked = value;
                                    _isAgree = false;
                                  });
                                }),
                            Text('동의하지 않음'),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        )
                      ],
                    )),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () async {
                        if (_isAgree == true) {
                          print('성공');
                          await _textMe();
                          Get.snackbar(
                              'SMS 전송완료', "SMS 상담 요청서를 해당 전문가에게 전송하였습니다.");
                        } else {
                          Get.snackbar('개인정보 이용동의',
                              '개인정보 이용에 동의하지 않으면 전문가에게 SMS 보내기를 사용할 수 없습니다. 관리자에게 문의하여 전문가 견적을 문의하세요');
                        }
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.sms,
                            color: Colors.blueAccent,
                            size: 18.0,
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            'SMS보내기',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueAccent,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(
                          width: 1.0,
                          color: Colors.blueAccent,
                        ),
                        elevation: 0.0,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_isAgree == true) {
                          RegisterEstimate_Data.updateState(estimate_id!)
                              .then((value) {
                            print(value);
                            if (value == "success") {
                              Get.offNamed(
                                  '/chat/true?estimate_id=$estimate_id&&user_id=$user_id&&com_name=$com_name&&isPro=Cus&&index=0&&token=$token');
                              //Get.toNamed('/chatlist/true?user_id=$user_id');
                            }
                          });
                        } else {
                          Get.snackbar('개인정보 이용동의',
                              '개인정보 이용에 동의하지 않으면 전문가에게 채팅 보내기를 사용할 수 없습니다.');
                        }
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.chat_outlined,
                            color: Colors.blueAccent,
                            size: 18.0,
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            '채팅보내기',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueAccent,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(
                          width: 1.0,
                          color: Colors.blueAccent,
                        ),
                        elevation: 0.0,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ));
  }
}
