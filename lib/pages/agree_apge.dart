import 'package:flutter/material.dart';
import 'package:flutter_film/pages/register_page.dart';
import 'package:get/get.dart';
import 'package:iamport_flutter/Iamport_certification.dart';
import 'package:iamport_flutter/model/certification_data.dart';

class AgreePage extends StatefulWidget{
  @override
  _AgreePageState createState() => _AgreePageState();
}

class _AgreePageState extends State<AgreePage>{

  bool _isAgree1 = false;
  bool _isAgree2 = false;
  bool _isAgree3 = false;
  bool _isAgree_all = false;
  TextEditingController phoneController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Text('회원가입', style:
        TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black,),
          onPressed: (){
            Get.back();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30.0,),
                Container(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
                  width: Get.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.black54)
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: Get.width,
                          height: 50.0,
                          color: Color(0xFFf2f2f2),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                  value: _isAgree_all,
                                  onChanged: (value) {
                                    setState(() {
                                      _isAgree_all = value!;
                                      _isAgree1 = value;
                                      _isAgree2 = value;
                                      _isAgree3 = value;
                                    });
                                  }
                              ),
                              Text('모두 동의하기', style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold),),
                            ],
                          )
                      ),
                      SizedBox(height: 20.0,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('개인정보수집 및 이용 동의 [필수]', style: TextStyle(color: Colors.black),),
                          Spacer(),
                          Checkbox(
                              value: _isAgree1,
                              onChanged: (value) {
                                setState(() {
                                  _isAgree1 = value!;
                                });
                              }
                          ),
                          Text('동의'),
                        ],
                      ),
                      SizedBox(height: 15.0,),
                      Text('1. 수집항목: 이름, 이메일, 핸드폰번호, 지역(주소), 시공계약시 견적서 및 계약서 내 계약자 정보\n'
                          '2. 수집 및 이용목적: 이용자 식별, 회원관리, 본인여부확인, 서비스 민원사항, 고충 처리 결과 안내'
                          '\n3.보요 및 이용 기간: 목적 달성 후 파기(단, 관계법령이 별도로 정한 경우 그에 따름)'
                          '\n4. 개인정보 제공에 동의하지 않을 수 있으며, 동의하지 않으면 서비스 이용이 제한 될 수 있음. 그 밖의 사항은 공간인테리어(필름반장) 개인정보처리방안에 있음',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Image.asset('assets/images/agree.png', fit: BoxFit.cover,),

                      SizedBox(height: 50.0,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('개인정보 제3자 제공 동의 [필수]', style: TextStyle(color: Colors.black),),
                          Spacer(),
                          Checkbox(
                              value: _isAgree2,
                              onChanged: (value) {
                                setState(() {
                                  _isAgree2 = value!;

                                });
                              }
                          ),
                          Text('동의'),
                        ],
                      ),
                      SizedBox(height: 15.0,),
                      Image.asset('assets/images/agree2.png'),

                      SizedBox(height: 50.0,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('개인정보 처리 [필수]',),
                          Spacer(),
                          Checkbox(
                              value: _isAgree3,
                              onChanged: (value) {
                                setState(() {
                                  _isAgree3 = value!;
                                });
                              }
                          ),
                          Text('동의'),
                        ],
                      ),
                      SizedBox(height: 15.0,),
                      Text('1. 회사는 회원의 개인정보를 보호하기 위해 정보통신망법 및 개인정보 보호법 등 관계법령에서 정하는 바를 준수하며 이용자의 개인 식별이 가능한 개인 정보를 수집하는 때에는 반드시 당해 이용자의 동의를 받습니다.\n'
                          '2. 회사의 개인정보 보호는 공간인테리어(필름반장) 개인정보 처리 방침에 따릅니다.',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.0,),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('본인인증', style:
                    TextStyle(
                        fontSize: 14.0,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold
                    ),
                    )
                ),
                SizedBox(height: 10.0,),
                Container(
                  width: Get.width,
                  height: Get.height*0.3,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.black54)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      SizedBox(height: 10.0,),
                      SizedBox(
                        height: 50.0,
                        width: Get.width*0.5,
                        child: TextField(
                          controller: nameController,
                          cursorHeight: 20.0,
                          style: TextStyle(
                              fontSize: 13.0
                          ),
                          decoration: InputDecoration(
                            fillColor: Color(0xFFF8F8F8),
                            filled: true,
                            labelText: '이름',
                            labelStyle: TextStyle(fontSize: 11.0),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      SizedBox(
                        height: 50.0,
                        width: Get.width*0.5,
                        child: TextField(
                          controller: phoneController,
                          cursorHeight: 20.0,
                          style: TextStyle(
                              fontSize: 13.0
                          ),
                          decoration: InputDecoration(
                            fillColor: Color(0xFFF8F8F8),
                            filled: true,
                            labelText: '휴대폰 번호를 입력하세요 (-제외)',
                            labelStyle: TextStyle(fontSize: 11.0),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: Get.width*0.3,
                          height: 35.0,
                          child: ElevatedButton(
                            child: Text('본인인증', style:
                            TextStyle(
                                fontSize: 14.0,
                                color: Color(0xFF398FE2),
                                fontWeight: FontWeight.bold
                            ),
                              textAlign: TextAlign.center,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              side: BorderSide(
                                width: 1.0, color: Color(0xFF398FE2),
                              ),
                              elevation: 0.0,
                            ),
                            onPressed: (){
                              if(_isAgree1 == true && _isAgree2 == true && _isAgree3 == true){
                                if(phoneController.text.isNotEmpty && nameController.text.isNotEmpty && phoneController.text.length == 11){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => Certification(
                                            phone: phoneController.text,
                                            name: nameController.text,
                                          )
                                      )
                                  );
                                }else{
                                  Get.snackbar("Error", "이름 또는 휴대폰 번호를 확인해주세요");
                                }

                              }else{
                                Get.snackbar("Error", "필수 약관을 확인해주세요");
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class Certification extends StatelessWidget {
  String phone;
  String name;
  Certification({required this.phone, required this.name});

  @override
  Widget build(BuildContext context) {
    return IamportCertification(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: new Text('필름반장 본인인증', style: TextStyle(color: Colors.black, fontSize: 15.0),),
      ),
      /* 웹뷰 로딩 컴포넌트 */
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20.0)),
              ),
            ],
          ),
        ),
      ),
      /* [필수입력] 가맹점 식별코드 */
      userCode: 'imp89727560',
      /* [필수입력] 본인인증 데이터 */
      data: CertificationData.fromJson({
        'merchantUid': 'mid_${DateTime.now().millisecondsSinceEpoch}',  // 주문번호
        'company': '필름반장(공간인테리어)',
        'name': name,                                                 // 이름
        'phone': phone, // 회사명 또는 URL
      }),
      /* [필수입력] 콜백 함수 */
      callback: (Map<String, String> result) {
        Get.offNamed('/register/true?result=$result&ph=$phone');
      },
    );
  }
}