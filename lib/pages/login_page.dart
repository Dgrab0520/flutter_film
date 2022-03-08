import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_film/datas/customer_area_data.dart';
import 'package:flutter_film/datas/login_pro_data.dart';
import 'package:flutter_film/models/userCheck_model.dart';
import 'package:flutter_film/pages/agree_apge.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/all.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isCustomer = true;
  List<User_Check>? _user_login;
  TextEditingController idController = new TextEditingController();
  TextEditingController pwController = new TextEditingController();
  bool? _isLogin;
  bool _isKakaoTalkInstalled = true;
  String userInfo = ""; //자동 로그인시 로그인 정보 저장

  static final storage =
      new FlutterSecureStorage(); //flutter_secure_storage 사용을 위한 초기화 작업

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initKakaoTalkInstalled();
    _isLogin = false;
    _user_login = [];
    //_getLogin();
    //비동기로 flutter secure storage 정보를 불러오는 작업.
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    userInfo = (await storage.read(key: "login"))!;
    print('userinfo?? $userInfo');

    //user의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.
    if (userInfo != null) {
      Get.offAllNamed('/orderList/true?id=${userInfo.split(" ")[1]}');
    }
  }

  //전문가로그인
  _getLogin() {
    Login_Data.getLogin(idController.text.trim(), pwController.text.trim())
        .then((user_login) {
      setState(() {
        //_user_login = user_login;
      });
      print(user_login);
      if (user_login.length == 1) {
        setState(() {
          _isLogin = true;
          print(_isLogin);
          storage.write(
              key: "login",
              value: "id " +
                  idController.text.toString() +
                  " " +
                  "password " +
                  pwController.text.toString());
          Get.offAllNamed('/orderList/true?id=${idController.text}');
        });
      } else {
        setState(() {
          _isLogin = false;
          Get.snackbar('로그인 실패', '로그인에 실패하였습니다. 아이디와 비밀번호를 확인해주세요');
          print(_isLogin);
        });
      }
    });
  }

  //고객 카카오 로그인
  _initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }

  _loginWithKakao() async {
    try {
      var code = await AuthCodeClient.instance.request();
      await _issueAccessToken(code);
      // await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

  _loginWithTalk() async {
    try {
      var code = await AuthCodeClient.instance.requestWithTalk();
      await _issueAccessToken(code);
      // await _issueAccessToken(code);
    } catch (e) {
      print(e.toString());
    }
  }

  _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      TokenManager.instance.setToken(token);
      Get.offAllNamed('/main/true?type=customer');
    } catch (e) {
      print("Error on issuing access token: $e");
    }
  }

  // _issueAccessToken(String authCode) async {
  //   try {
  //     var token = await AuthApi.instance.issueAccessToken(authCode);
  //     TokenManager.instance.toStore(token);
  //     Get.toNamed('/main/true?type=customer');
  //   } catch (e) {
  //     print("error on issuing access token: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // KaKao native app key
    KakaoContext.clientId =
        "9e7b120390d4b5e500c1979c182d62d5"; //Native Key  //오류 발생 시 initState() 밑에 넣어보기
    // KaKao javascript key
    KakaoContext.javascriptClientId =
        "28531eb53356ce1208b9358ecd53cc77"; //JavaScript Key

    isKakaoTalkInstalled();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            '로그인',
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
              Get.offAllNamed('/main/false');
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                _isCustomer
                    ? Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: <Widget>[
                                      TextButton(
                                        child: Text(
                                          '고객 로그인',
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isCustomer = true;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Container(
                                          color: Color(0xFF398FE2),
                                        ),
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: <Widget>[
                                      TextButton(
                                        child: Text(
                                          '전문가 로그인',
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isCustomer = false;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Container(
                                          color: Color(0xFFd6d6d6),
                                        ),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 80.0,
                          ),
                          SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/logo.gif',
                                    width: Get.width * 0.6,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.08,
                                  ),
                                  Container(
                                      width: 180.0,
                                      height: 40.0,
                                      color: Colors.yellow,
                                      child: FlatButton(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.messenger,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Text(
                                              '카카오톡 로그인',
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        onPressed: () => _loginWithKakao(),
                                      )),
                                  SizedBox(
                                    height: 250.0,
                                  ),

                                  Text(
                                    '고객센터',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87),
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Text(
                                    '대표번호 : 02-2625-3868',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54),
                                  ),
                                  SizedBox(
                                    height: 3.0,
                                  ),
                                  Text(
                                    '이메일 : apt9785@naver.com',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54),
                                  ),
                                  SizedBox(
                                    height: 3.0,
                                  ),
                                  Text(
                                    '제휴문의 : gowjr0771@naver.com',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54),
                                  ),
                                  SizedBox(
                                    height: 50.0,
                                  )
                                ],
                              ))
                        ],
                      )
                    : Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: <Widget>[
                                      TextButton(
                                        child: Text(
                                          '고객 로그인',
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isCustomer = true;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Container(
                                          color: Color(0xFFd6d6d6),
                                        ),
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: <Widget>[
                                      TextButton(
                                        child: Text(
                                          '전문가 로그인',
                                          style: TextStyle(
                                            color: Color(0xFF398FE2),
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isCustomer = false;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Container(
                                          color: Color(0xFF398FE2),
                                        ),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  controller: idController,
                                  cursorHeight: 20.0,
                                  style: TextStyle(fontSize: 13.0, height: 1.0),
                                  decoration: InputDecoration(
                                    labelText: '아이디 (이메일)을 입력해주세요',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                TextField(
                                  controller: pwController,
                                  cursorHeight: 20.0,
                                  obscureText: true,
                                  style: TextStyle(fontSize: 13.0, height: 1.0),
                                  decoration: InputDecoration(
                                    labelText: '비밀번호를 입력해주세요',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Spacer(),
                              TextButton(
                                child: Text(
                                  '아이디 찾기',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 13.0),
                                ),
                                onPressed: () {
                                  Get.toNamed('/searchid/true?content=ID');
                                  print('아이디 찾기');
                                },
                              ),
                              Text('|'),
                              TextButton(
                                child: Text(
                                  '비밀번호 찾기',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 13.0),
                                ),
                                onPressed: () {
                                  Get.toNamed('/searchpw/true?content=PW');
                                  print('비밀번호 찾기');
                                },
                              ),
                              Text('|'),
                              TextButton(
                                child: Text(
                                  '회원가입',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 13.0),
                                ),
                                onPressed: () {
                                  //Get.to(RegisterPage());
                                  Get.to(AgreePage());
                                  print('회원가입');
                                },
                              ),
                              SizedBox(
                                width: 20.0,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ButtonTheme(
                            minWidth: MediaQuery.of(context).size.width * 0.7,
                            height: 45.0,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  '로그인',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  _getLogin();
                                }),
                          )
                        ],
                      )
              ])),
        ));
  }
}
