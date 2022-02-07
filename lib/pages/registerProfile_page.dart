import 'package:flutter/material.dart';
import 'package:flutter_film/datas/registerP_Profile_data.dart';
import 'package:flutter_film/pages/login_page.dart';
import 'package:get/get.dart';

class RegisterProfilePage extends StatefulWidget{
  @override
  _RegisterProfilePageState createState() => _RegisterProfilePageState();
}

class _RegisterProfilePageState extends State<RegisterProfilePage>{

  TextEditingController introduceController = new TextEditingController();
  TextEditingController basicController = new TextEditingController();
  TextEditingController comController = new TextEditingController();
  String? pro_id;

  @override
  void initState(){
    pro_id = Get.parameters['id'];
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  //전문가 회원 회원가입
  _addProfile(){
    RegisterProfile_Data.addProfile(pro_id!, introduceController.text, basicController.text, comController.text).then((result){
        Get.offNamed('/loginPage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Text('$pro_id 프로필 등록', style:
        TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        ),

      ),
      backgroundColor: Color(0xFFF0F0F0),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0,),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 15.0),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 15.0,),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/defaultImage.png'),
                      backgroundColor: Colors.white,
                      radius: 60.0,
                    ),
                    SizedBox(height: 15.0,),
                  ],
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('전문가 정보', style:
                    TextStyle(
                        color: Color(0XFF398FE2),
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0
                    ),
                    ),
                    SizedBox(height: 3.0,),
                    SizedBox(
                      child: Container(
                        width: 60.0,
                        height: 2.0,
                        color: Color(0XFF398FE2),
                      ),
                    ),
                    SizedBox(height: 30.0,),
                    Text('소개', style:
                      TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Container(
                      height: 80.0,
                      child: TextField(
                        controller: introduceController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        cursorHeight: 20.0,
                        style: TextStyle(
                            fontSize: 13.0, height: 1.0
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: '간단한 소개를 작성해주세요(200자 이내)',
                          labelStyle: TextStyle(fontSize: 11.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF636363), width: 0.5),
                          ),
                          border: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
                        ),
                      ),
                    ),
                    Text('서비스 가능 지역 / 연락 가능 시간', style:
                    TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0
                    ),
                    ),
                    SizedBox(height: 15.0,),
                    Container(
                      height: 80.0,
                      child: TextField(
                        controller: basicController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        cursorHeight: 20.0,
                        style: TextStyle(
                            fontSize: 13.0, height: 1.0
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: '200자 이내로 입력해주세요',
                          labelStyle: TextStyle(fontSize: 11.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF636363), width: 0.5),
                          ),
                          border: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
                        ),
                      ),
                    ),

                    Text('경력 / 직원 수 / 사업자 등록 여부', style:
                      TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Container(
                      height: 80.0,
                      child: TextField(
                        controller: comController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        cursorHeight: 20.0,
                        style: TextStyle(
                            fontSize: 13.0, height: 1.0
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: '200자 이내로 입력해주세요',
                          labelStyle: TextStyle(fontSize: 11.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF636363), width: 0.5),
                          ),
                          border: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
                        ),
                      ),
                    ),
                    Text('프로필사진 변경 및 포트폴리오 등록은 로그인 후 설정 페이지에서 이용할 수 있습니다', style:
                      TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15.0,),

                  ],
                ),
              ),
              SizedBox(height: 20.0,),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    child: Text('프로필 저장', style:
                    TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold
                    ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFF398FE2)
                    ),
                    onPressed: (){
                      _addProfile();
                    },
                  ),
                ),
              ),
              SizedBox(height: 50.0,),
            ],
          ),
        ),
      ),
    );
  }
}
