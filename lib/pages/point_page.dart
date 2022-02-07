import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_film/datas/pro_point_data.dart';
import 'package:flutter_film/datas/register_pointinfo_data.dart';
import 'package:flutter_film/datas/userCheck_data.dart';
import 'package:flutter_film/models/pro_point_model.dart';
import 'package:flutter_film/models/userCheck_model.dart';
import 'package:get/get.dart';
/* 아임포트 결제 모듈을 불러옵니다. */
import 'package:iamport_flutter/iamport_payment.dart';
/* 아임포트 결제 데이터 모델을 불러옵니다. */
import 'package:iamport_flutter/model/payment_data.dart';


class PointPage extends StatefulWidget {

  @override
  _PointPageState createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {

  bool _is10000 = false;
  bool _is30000 = false;
  bool _is50000 = false;
  String? _userId;
  String? point;
  int? _selectedValue;
  bool? _isLoading;
  List<Pro_Point>? _pro_point;
  List<User_Check>? _user_info;


  @override
  void dispose(){
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    _isLoading = false;
    _userId = Get.parameters['id'];
    _pro_point = [];
    _user_info = [];
    _getProPoint();
    _getUserInfo();
  }

  _getProPoint(){
    ProPoint_Data.getProPoint(_userId!).then((pro_point){
      setState(() {
        _pro_point = pro_point;
      });
      if(pro_point.length == 0){
        _isLoading = false;
      }else{
        setState(() {
          _isLoading = true;
        });
      }
    });
  }

  _getUserInfo(){
    UserCheck_Data.getUserCheck(_userId!).then((user_info){
      setState(() {
        _user_info = user_info;
      });
      if(user_info.length == 0){
        setState(() {
          _isLoading = false;
        });
      }else{
        setState(() {
          _isLoading = true;
        });
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Text('포인트 충전', style:
        TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Color(0xFFF0F0F0),
      resizeToAvoidBottomInset : false,
      body:SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50.0,),
              _isLoading!
                  ?
              Text(
                '보유 포인트 : ${_pro_point![0].total_point}',
                style: const TextStyle(
                  fontSize:20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF398FE2),
                ),
              )
                  :
              Text(
                '보유 포인트 : 0',
                style: const TextStyle(
                  fontSize:20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF398FE2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:30,),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        width: MediaQuery.of(context).size.width*0.75,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.5, color: Color(0xFF707070)), // 박스 테두리 만들기
                          borderRadius: BorderRadius.circular(10), //박스 둥글게 만들기
                        ),
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                              value: _is10000,
                              onChanged: (value){
                                setState(() {
                                  _is10000 = value!;
                                  _selectedValue = 10000;
                                  _is30000 = false;
                                  _is50000 = false;
                                });
                              },
                            ),
                            SizedBox(width: 5.0,),
                            Text('10000원', style:
                            TextStyle(
                              fontSize:20,
                              fontWeight: FontWeight.w400,
                            ),
                            ),
                            Spacer(),
                            Text('10000P', style:
                            TextStyle(
                              fontSize:20,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF398FE2),
                            ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        width: MediaQuery.of(context).size.width*0.75,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.5, color: Color(0xFF707070)), // 박스 테두리 만들기
                          borderRadius: BorderRadius.circular(10), //박스 둥글게 만들기
                        ),
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                              value: _is30000,
                              onChanged: (value){
                                setState(() {
                                  _is30000 = value!;
                                  _selectedValue = 30000;
                                  _is10000 = false;
                                  _is50000 = false;
                                });
                              },
                            ),
                            SizedBox(width: 5.0,),
                            Text('30000원', style:
                            TextStyle(
                              fontSize:20,
                              fontWeight: FontWeight.w400,
                            ),
                            ),
                            Spacer(),
                            Text('30000P', style:
                            TextStyle(
                              fontSize:20,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF398FE2),
                            ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.0,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        width: MediaQuery.of(context).size.width*0.75,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.5, color: Color(0xFF707070)), // 박스 테두리 만들기
                          borderRadius: BorderRadius.circular(10), //박스 둥글게 만들기
                        ),
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                              value: _is50000,
                              onChanged: (value){
                                setState(() {
                                  _is50000 = value!;
                                  _selectedValue = 50000;
                                  _is10000 = false;
                                  _is30000 = false;
                                });
                              },
                            ),
                            SizedBox(width: 5.0,),
                            Text('50000원', style:
                            TextStyle(
                              fontSize:20,
                              fontWeight: FontWeight.w400,
                            ),
                            ),
                            Spacer(),
                            Text('50000P', style:
                            TextStyle(
                              fontSize:20,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF398FE2),
                            ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.0,),
                    ]
                ),
              ),
              SizedBox(height:30,),
              SizedBox(
                width: 200.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0,),
                  child: ElevatedButton(
                      child:Text('충전하기', style:
                        TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      onPressed: (){
                        if(_is10000 || _is30000 || _is50000){
                          // _addPointInfo();
                          Get.defaultDialog(
                            title: '결제하기',
                            titleStyle: TextStyle(
                              fontSize: 13.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold
                            ),
                            content: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                                width: Get.width*0.9,
                                height: Get.height*0.35,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                              width: 100.0,
                                              height: 35.0,
                                              decoration: BoxDecoration(
                                                  border: Border.all(width: 1.0, color: Colors.redAccent),
                                                  color: Colors.redAccent
                                              ),
                                              child: Center(
                                                child: Text('결제일', style:
                                                TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                ),
                                              )
                                          ),
                                        ),
                                        SizedBox(width: 5.0,),
                                        Expanded(
                                          flex: 5,
                                          child: Container(
                                              width: 100.0,
                                              height: 35.0,
                                              decoration: BoxDecoration(
                                                  border: Border.all(width: 1.0, color: Colors.redAccent),
                                                  color: Colors.white
                                              ),
                                              child: Center(
                                                child: Text(DateTime.now().toString().substring(0, DateTime.now().toString().lastIndexOf(" ")), style:
                                                TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                                ),
                                              )
                                          ),
                                        )

                                      ],
                                    ),
                                    SizedBox(height: 5.0,),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                              width: 100.0,
                                              height: 35.0,
                                              decoration: BoxDecoration(
                                                  border: Border.all(width: 1.0, color: Colors.redAccent),
                                                  color: Colors.redAccent
                                              ),
                                              child: Center(
                                                child: Text('금액', style:
                                                TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                ),
                                              )
                                          ),
                                        ),
                                        SizedBox(width: 5.0,),
                                        Expanded(
                                          flex: 5,
                                          child: Container(
                                              width: 100.0,
                                              height: 35.0,
                                              decoration: BoxDecoration(
                                                  border: Border.all(width: 1.0, color: Colors.redAccent),
                                                  color: Colors.white
                                              ),
                                              child: Center(
                                                child: Text('$_selectedValue 원', style:
                                                TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                                ),
                                              )
                                          ),
                                        )

                                      ],
                                    ),
                                    SizedBox(height: 5.0,),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                              width: 100.0,
                                              height: 35.0,
                                              decoration: BoxDecoration(
                                                  border: Border.all(width: 1.0, color: Colors.redAccent),
                                                  color: Colors.redAccent
                                              ),
                                              child: Center(
                                                child: Text('사용자', style:
                                                TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                ),
                                              )
                                          ),
                                        ),
                                        SizedBox(width: 5.0,),
                                        Expanded(
                                          flex: 5,
                                          child: Container(
                                              width: 100.0,
                                              height: 35.0,
                                              decoration: BoxDecoration(
                                                  border: Border.all(width: 1.0, color: Colors.redAccent),
                                                  color: Colors.white
                                              ),
                                              child: Center(
                                                child: Text('$_userId', style:
                                                TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                                ),
                                              )
                                          ),
                                        )

                                      ],
                                    ),
                                    SizedBox(height: 5.0,),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                              width: 100.0,
                                              height: 35.0,
                                              decoration: BoxDecoration(
                                                  border: Border.all(width: 1.0, color: Colors.redAccent),
                                                  color: Colors.redAccent
                                              ),
                                              child: Center(
                                                child: Text('전화번호', style:
                                                TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                ),
                                              )
                                          ),
                                        ),
                                        SizedBox(width: 5.0,),
                                        Expanded(
                                          flex: 5,
                                          child: Container(
                                              width: 100.0,
                                              height: 35.0,
                                              decoration: BoxDecoration(
                                                  border: Border.all(width: 1.0, color: Colors.redAccent),
                                                  color: Colors.white
                                              ),
                                              child: Center(
                                                  child: Text('${_user_info![0].phone_number}', style:
                                              const TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                              ),
                                              )
                                          ),
                                        )

                                      ],
                                    ),
                                    SizedBox(height: 10.0,),
                                    ElevatedButton(
                                      child:Text('충전하기', style:
                                        TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      onPressed: (){
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => Payment(
                                                    pay: _selectedValue!,
                                                    users: Users(
                                                      userId: _userId!,
                                                      userPH: _user_info![0].phone_number,
                                                      userEM: _user_info![0].user_email,
                                                    )
                                                )
                                            )
                                        );
                                      }
                                    )
                                  ],
                                ),
                              ),
                            )
                          );
                        }else{
                          Get.defaultDialog(title: 'Note', titleStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold), middleText: '충전할 포인트를 선택하세요');
                        }
                      }
                  ),
                )
              ),
              TextButton(
                onPressed: (){
                  Get.toNamed('/notice/true?sub=이용약관');
                },
                child: Text('이용약관', style:
                  TextStyle(
                    color: Colors.grey
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Users{
  String userId;
  String userPH;
  String userEM;

  Users({required this.userId, required this.userPH, required this.userEM});
}

class Payment extends StatelessWidget {

  Payment({required this.pay, required this.users});
  int pay;
  Users users;

  _addPointInfo(){
    Register_PointInfo.addPointInfo(users.userId, this.pay.toString(), '포인트 충전').then((result){
      if(result == 'success'){
        print('addpointInfo success');
        //Get.offNamed('/deposit/:true?pro_id=$_userId');
      }else{
        print('addpointInfo fail');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return IamportPayment(
      appBar: new AppBar(
        title: new Text('결제하기'),
      ),
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: Text('잠시만 기다려 주세요'),
              ),
            ],
          )
        )
      ),
      userCode: 'imp89727560',
      data: PaymentData.fromJson({
        'pg': 'danal_tpay',                                          // PG사
        'payMethod': 'card',                                           // 결제수단
        'name': '필름반장(공간인테리어)',                                  // 주문명
        'merchantUid': 'mid_${DateTime.now().millisecondsSinceEpoch}', // 주문번호
        'amount': this.pay,                                               // 결제금액
        'buyerName': users.userId,                                           // 구매자 이름
        'buyerTel': users.userPH,                                     // 구매자 연락처
        'buyerEmail': users.userEM,                             // 구매자 이메일
        // 'buyerAddr': '서울시 송파구 오금로 40길 40 402',                         // 구매자 주소
        // 'buyerPostcode': '05822',                                      // 구매자 우편번호
        'appScheme': '필름반장 포인트 충전',                                        // 앱 URL scheme
        'display': {
          'cardQuota' : [2,3]                                          //결제창 UI 내 할부개월수 제한
        }
      }),
        callback: (Map<String, String> result) {
          print(result['imp_success']);
          if(result['imp_success'] == "false"){
            _addPointInfo();
            Get.back();
          }else{
            Get.offNamed(
              '/deposit/:true?pro_id=${users.userId}&&result=$result',
            );
          }


        },
    );
  }
}
