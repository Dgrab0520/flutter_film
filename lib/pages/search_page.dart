import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iamport_flutter/Iamport_certification.dart';
import 'package:iamport_flutter/model/certification_data.dart';

class SearchPage extends StatefulWidget{
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>{

  String? searchContent;
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController idController = new TextEditingController();


  @override
  void initState() {
    super.initState();
    searchContent = Get.parameters['content'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Text('$searchContent 찾기', style:
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
      backgroundColor: Colors.white,
      body: Container(
          height: Get.height*0.9,
          width: Get.width,
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 100.0,),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('ID찾기', style:
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
                height: Get.height*0.4,
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.black54)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10.0,),
                    SizedBox(
                      height: 50.0,
                      width: Get.width*0.6,
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
                      width: Get.width*0.6,
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
                            if(phoneController.text.isNotEmpty && nameController.text.isNotEmpty && phoneController.text.length == 11){
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Certification(
                                        id: 'None',
                                        phone: phoneController.text,
                                        name: nameController.text,
                                      )
                                  )
                              );
                            }else{
                              Get.snackbar("Error", "이름 또는 휴대폰 번호를 확인해주세요");
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.0,),
            ],
          )
      ),
    );
  }
}


class Certification extends StatelessWidget {
  String id;
  String phone;
  String name;

  Certification({required this.id, required this.phone, required this.name});

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
        print('result : $result');
        if(result['success'] == 'true'){
          Get.offNamed('/searchResult/ID?user_id=${id}&&user_phone=${phone}');
        }else{
          Get.back();
        }

      },
    );
  }
}