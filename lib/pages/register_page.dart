import 'package:flutter/material.dart';
import 'package:flutter_film/datas/register_Pro_data.dart';
import 'package:flutter_film/datas/userCheck_data.dart';
import 'package:flutter_film/models/userCheck_model.dart';
import 'package:get/get.dart';
import 'package:iamport_flutter/Iamport_certification.dart';
import 'package:iamport_flutter/model/certification_data.dart';



class RegisterPage extends StatefulWidget{
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{

  TextEditingController idController = new TextEditingController();
  TextEditingController pwController = new TextEditingController();
  TextEditingController checkController = new TextEditingController();
  TextEditingController comNameController = new TextEditingController();
  TextEditingController comNoController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController authController = new TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final _valueList = ["선택","수도권", "부산", "대구", "광주", "대전", "울산", "세종", "강원", "경남", "경북", "전남", "전북", "충남", "충북", "제주"];
  var _selectedValue1 = '선택';
  var _selectedValue2 = '선택';
  var _selectedValue3 = '선택';
  bool _ispwCheck = false;
  bool _ispwLength = false;
  bool _isOverlap = true;
  final _valueList4 = ["선택", "조공(3개월 ~ 2년 미만)", "준기공(2년~5년 미만)", "조공(3년 이상)", "실장", "팀장"];
  var _selectedValue4 = '선택';
  List<User_Check>? _user_check;
  String? ph;


  @override
  void initState(){
    _user_check = [];
    ph = Get.parameters['ph'];
    idController = TextEditingController();
    pwController = TextEditingController();
    checkController = TextEditingController();
    emailController = TextEditingController();
    authController = TextEditingController();
    comNameController = TextEditingController();
    comNoController = TextEditingController();
    super.initState();
  }

  @override
  void dispose(){
    _selectDate;
    super.dispose();
  }


  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2999)
    );
    if(picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }


  //전문가 회원 회원가입
  _addProUser(){
    if(idController.text.isEmpty || pwController.text.isEmpty || checkController.text.isEmpty || emailController.text.isEmpty || comNameController.text.isEmpty || _selectedValue1 == '선택' || _selectedValue2 == '선택'){
      Get.snackbar('회원가입 실패', '값이 입력되지 않았습니다.\n확인 후 회원가입을 완료해주세요');
      return;
    }else{
      if(_ispwLength && _ispwCheck && _isOverlap == false) {
        print('회원가입 완료');
        ProUser_Data.addProUser(idController.text.trim(), pwController.text.trim(), _selectedValue4, emailController.text.trim(), ph!, comNameController.text.trim(), comNoController.text.trim(), _selectedValue1, _selectedValue2, _selectedValue3).then((result){
        Get.offNamed('/registerProfilePage/true?id=${idController.text}');
        });
        return;
      }else{
        print('입력을 확인 해주세요');
        return;
      }
    }
  }

  //중복확인
  _getUserCheck(){
    UserCheck_Data.getUserCheck(idController.text).then((user_check){
      setState(() {
        _user_check = user_check;
      });
      if(user_check.length == 0){
        setState(() {
          _isOverlap = false;
        });
      }else{
        setState(() {
          _isOverlap = true;
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
        title: Text('회원가입', style:
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
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: Color(0xFFF0F0F0),

            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: idController,
                        onChanged: (String value){
                          setState(() {
                            _isOverlap = true;
                          });
                        },
                        cursorHeight: 20.0,
                        style: TextStyle(
                            fontSize: 13.0, height: 0.5
                        ),
                        decoration: InputDecoration(
                          fillColor: Color(0xFFF8F8F8),
                          filled: true,
                          labelText: '아이디 (이메일)',
                          labelStyle: TextStyle(fontSize: 11.0),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        child: Text('중복확인', style:
                        TextStyle(
                            fontSize: 13.0
                        ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFF398FE2)
                        ),
                        onPressed: (){
                          _getUserCheck();
                          print('중복확인');
                        },
                      ),
                    )
                  ],
                ),
                _isOverlap
                    ?
                Text('아이디를 사용할 수 없습니다.', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),)
                    :
                Text('아이디를 사용할 수 있습니다.', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),),
                SizedBox(height: 20.0,),
                TextField(
                  controller: pwController,
                  obscureText: true,
                  onChanged: (String value){
                    if(value.toString() == checkController.text && value.length > 9){
                      setState(() {
                        _ispwCheck = true;
                        _ispwLength = true;
                      });
                    }else{
                      setState(() {
                        _ispwCheck = false;
                        _ispwLength = false;
                      });
                    }
                  },
                  cursorHeight: 20.0,
                  style: TextStyle(
                      fontSize: 13.0, height: 0.5
                  ),
                  decoration: InputDecoration(
                    fillColor: Color(0xFFF8F8F8),
                    filled: true,
                    labelText: '비밀번호 (10자 이상)',
                    labelStyle: TextStyle(fontSize: 11.0),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8.0,),
                TextField(
                  controller: checkController,
                  obscureText: true,
                  onChanged: (String value){
                    if (value.toString() == pwController.text && value.length > 9) {
                      setState(() {
                        _ispwCheck = true;
                        _ispwLength = true;
                      });
                    }else{
                      setState(() {
                        _ispwCheck = false;
                        _ispwLength = false;
                      });
                    }
                  },
                  cursorHeight: 20.0,
                  style: TextStyle(
                      fontSize: 13.0, height: 0.5
                  ),
                  decoration: InputDecoration(
                    fillColor: Color(0xFFF8F8F8),
                    filled: true,
                    labelText: '비밀번호 확인',
                    labelStyle: TextStyle(fontSize: 11.0),
                    border: OutlineInputBorder(),
                  ),
                ),
                _ispwCheck
                    ?
                Text('비밀번호가 일치합니다.', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),)
                    :
                Text('비밀번호가 일치하지 않습니다.', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),),
                SizedBox(height: 20.0,),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    color: Color(0xFFF0F0F0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('숙련도 (향후 인증 절차 필요)'),
                        SizedBox(height: 10.0,),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            height: 45.0,
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: Color(0xFFF8F8F8),
                                border: Border.all(width: 0.5, color: Color(0xFF636363)),
                                borderRadius: BorderRadius.circular(3.0)
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedValue4,
                                items: _valueList4.map(
                                        (value){
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value, style: TextStyle(color: Colors.black),),
                                      );
                                    }
                                ).toList(),
                                onChanged: (value){
                                  setState(() {
                                    _selectedValue4 = value!;
                                  });
                                },
                              ),
                            )
                        )
                      ],
                    )
                ),
                SizedBox(height: 20.0,),
                TextField(
                  controller: emailController,
                  cursorHeight: 20.0,
                  style: TextStyle(
                      fontSize: 13.0, height: 0.5
                  ),
                  decoration: InputDecoration(
                    fillColor: Color(0xFFF8F8F8),
                    filled: true,
                    labelText: '이메일을 입력해주세요',
                    labelStyle: TextStyle(fontSize: 11.0),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0,),
                Text('휴대폰 번호', style:
                TextStyle(
                  color: Colors.black,
                  fontSize: 13.0,
                ),
                ),
                SizedBox(height: 5.0,),
                Container(
                  width: Get.width,
                  height: 50.0,
                  color: Color(0xFFd4d4d4),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('$ph',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20.0),),
                  )
                ),
                SizedBox(height: 20.0,),
                TextField(
                  controller: comNameController,
                  cursorHeight: 20.0,
                  style: TextStyle(
                      fontSize: 13.0, height: 0.5
                  ),
                  decoration: InputDecoration(
                    fillColor: Color(0xFFF8F8F8),
                    filled: true,
                    labelText: '이름(실명) 또는 회사명',
                    labelStyle: TextStyle(fontSize: 11.0),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8.0,),
                TextField(
                  controller: comNoController,
                  cursorHeight: 20.0,
                  style: TextStyle(
                      fontSize: 13.0, height: 0.5
                  ),
                  decoration: InputDecoration(
                    fillColor: Color(0xFFF8F8F8),
                    filled: true,
                    labelText: '사업자 번호 (선택)',
                    labelStyle: TextStyle(fontSize: 11.0),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0,),
                Text('작업 가능 지역', style:
                TextStyle(
                  color: Colors.grey,
                  fontSize: 13.0,
                ),
                ),
                //SizedBox(height: 8.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('1순위', style:
                    TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                    ),
                    SizedBox(width: 5.0,),
                    DropdownButton<String>(
                      value: _selectedValue1,
                      items: _valueList.map(
                              (value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: TextStyle(color: Colors.grey),),
                            );
                          }
                      ).toList(),
                      onChanged: (value){
                        setState(() {
                          _selectedValue1 = value!;
                        });
                      },
                    ),
                    SizedBox(width: 10.0,),
                    Text('2순위', style:
                    TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                    ),
                    SizedBox(width: 5.0,),
                    DropdownButton<String>(
                      value: _selectedValue2,
                      items: _valueList.map(
                              (value){
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value, style: TextStyle(color: Colors.grey),),
                            );
                          }
                      ).toList(),
                      onChanged: (value){
                        setState(() {
                          _selectedValue2 = value!;
                        });
                      },
                    ),
                    SizedBox(width: 10.0,),
                    Text('3순위', style:
                    TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                    ),
                    SizedBox(width: 5.0,),
                    DropdownButton<String>(
                      value: _selectedValue3,
                      items: _valueList.map(
                              (value){
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value, style: TextStyle(color: Colors.grey),),
                            );
                          }
                      ).toList(),
                      onChanged: (value){
                        setState(() {
                          _selectedValue3 = value!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30.0,),
                Container(

                ),
                SizedBox(height: 30.0,),
                Row(
                  children: <Widget>[
                    Spacer(),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        child: Text('회원가입', style:
                        TextStyle(
                            fontSize: 13.0
                        ),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFF398FE2)
                        ),
                        onPressed: (){
                          _addProUser();
                        },
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 15.0,)
              ],
            ),
          ),
        ),
      )
    );
  }
}

class Certification extends StatelessWidget {
  String phone;
  Certification({required this.phone});

  @override
  Widget build(BuildContext context) {
    return IamportCertification(
      appBar: new AppBar(
        title: new Text('필름반장 본인인증'),
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
        'company': '필름반장(공간인테리어)',                                            // 회사명 또는 URL
        // 'carrier': 'KT',                                               // 통신사
        // 'name': '이도원',                                                 // 이름
        // 'phone': '01044785303',                                         // 전화번호
      }),
      /* [필수입력] 콜백 함수 */
      callback: (Map<String, String> result) {
        Get.back(result: result);
        // Navigator.pushReplacementNamed(
        //   context,
        //   '/loginPage',
        //   arguments: result,
        // );
      },
    );
  }
}
