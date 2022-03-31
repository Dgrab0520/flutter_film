import 'package:flutter/material.dart';
import 'package:flutter_film/datas/ad_data.dart';
import 'package:flutter_film/datas/customerCheck_data.dart';
import 'package:flutter_film/datas/pro_recom_data.dart';
import 'package:flutter_film/models/ad_model.dart';
import 'package:flutter_film/models/customerCheck_model.dart';
import 'package:flutter_film/models/pro_recom_model.dart';
import 'package:flutter_film/pages/login_page.dart';
import 'package:flutter_film/pages/prolist_page.dart';
import 'package:flutter_film/widgets/carousel_slider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:select_form_field/select_form_field.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? _isLogin;
  String? _userId;
  String? _userType;
  bool _isLoading = false;
  bool _isAdLoading = false;
  List<Customer_Check>? _customerCheck;
  List<Pro_User> _proUser = [];
  List<Ad> _ad = [];
  bool? _isCS;
  String? skill;
  String selected = '수도권';
  static final storage = FlutterSecureStorage();

  final List<Map<String, dynamic>> _items = [
    {
      'value': '수도권',
      'label': '수도권',
    },

    {"value": "부산", "label": "부산"},
    {"value": "대구", "label": "대구"},
    {"value": "광주", "label": "광주"},
    {"value": "대전", "label": "대전"},
    {"value": "울산", "label": "울산"},
    {"value": "세종", "label": "세종"},
    {"value": "강원", "label": "강원"},
    {"value": "경남", "label": "경남"},
    {"value": "경북", "label": "경북"},
    {"value": "전남", "label": "전남"},
    {"value": "전북", "label": "전북"},
    {"value": "충남", "label": "충남"},
    {"value": "충북", "label": "충북"},
    {"value": "제주", "label": "제주"},
    // {
    //   'value': '경기',
    //   'label': '경기',
    // },
    // {
    //   'value': '인천',
    //   'label': '인천',
    // },
  ];

  @override
  void dispose() {
    super.dispose();
    _getProRecom();
    _getBanner();
  }

  @override
  void initState() {
    super.initState();
    _initTexts();
    _isCS = true;
    _customerCheck = [];
    //_proUser = [];
    _isLogin = Get.parameters['param'];
    print('Is login = $_isLogin');
    _userId = Get.parameters['id'];
    print(_userId);
    _userType = Get.parameters['type'];
    _isLoading = false;
    _getProRecom();
    //_ad = [];
    _getBanner();
  }

  //고객 회원가입 여부 조회
  _getCustomer() {
    if (_userType == 'customer') {
      setState(() {
        print("_userId : $_userId");
        CustomerCheck_Data.getCustomerCheck(user_id).then((customerCheck) {
          setState(() {
            _customerCheck = customerCheck;
          });
          print(user_id);
          print("_userId : $_userId");
          print(customerCheck.length);
          if (customerCheck.isEmpty == false) {
            setState(() {
              _isCS = true;
            });
          } else {
            setState(() {
              _isCS = false;
              Get.offNamed('/registerCustomer/true?id=$_userId');
            });
          }
        });
      });
    }
  }

  //전문가 추천
  _getProRecom() {
    ProUser_Data.getProRecom(selected).then((proUser) {
      setState(() {
        _proUser = proUser;
      });
      if (proUser.isEmpty) {
        _isLoading = false;
      } else {
        _isLoading = true;
      }
    });
  }

  _getBanner() {
    Ad_Data.getAd().then((ad) {
      print(ad);
      setState(() {
        _ad = ad;
      });
      if (ad.isEmpty) {
        _isAdLoading = false;
      } else {
        _isAdLoading = true;
      }
    });
    print("_ad : $_ad");
  }

  _initTexts() async {
    final User user = await UserApi.instance.me();
    setState(() {
      user_id = user.kakaoAccount!.email!;
      _default_Image = user.kakaoAccount!.profile!.isDefaultImage!;
      profile_image = user.kakaoAccount!.profile!.profileImageUrl!;
    });
    print("user_id : $user_id");
    _getCustomer();
  }

  String user_id = 'None';
  String profile_image = 'None';
  bool _default_Image = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Image.asset(
          'assets/images/logo_maini.png',
          width: 150.0,
          fit: BoxFit.cover,
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
              Container(
                width: Get.width,
                height: Get.height * 0.4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  // colorFilter: ColorFilter.mode(
                  //     Colors.black.withOpacity(0.5), BlendMode.dstATop
                  // ),
                  image: AssetImage(
                    _isLogin == 'true'
                      ?
                      'assets/images/back_login2.jpg'
                      :
                      'assets/images/interior5.jpg',
                  ),
                )),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: Get.width * 0.9,
                        height: Get.width * 0.5,
                        decoration:
                            BoxDecoration(border: Border.all(width: 0.5)),
                      ),
                      // Image.asset('assets/images/rec.png', fit: BoxFit.cover,),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: <Widget>[
                            Spacer(),
                            SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '인테리어필름 ',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFEA316F)),
                                ),
                                Text(
                                  '시공 전문가를 만나보세요',
                                  style: TextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            Text(
                              '전문가에게 비교견적 받아보세요',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w700),
                            ),
                            // Text(
                            //   '비교견적 1분 OK',
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //       fontSize: 14.0,
                            //       color: Colors.grey,
                            //       fontWeight: FontWeight.w700),
                            // ),
                            // Text('5명의 전문가로 비교견적 받아보세요', textAlign: TextAlign.center,  style:
                            //   TextStyle(
                            //       fontSize: 15.0,
                            //       color: Colors.black54,
                            //       fontWeight: FontWeight.w700
                            //   ),
                            // ),
                            // Text('(3명 이상의 시공자가 바로 견적 보내드립니다)', textAlign: TextAlign.center,  style:
                            //   TextStyle(
                            //       fontSize: 14.0,
                            //       color: Colors.grey,
                            //       fontWeight: FontWeight.w700
                            //   ),
                            // ),
                            SizedBox(
                              height: 40.0,
                            ),

                            _isLogin == 'true'
                                ? _userType == 'customer'
                                    ? ButtonTheme(
                                        minWidth: Get.width * 0.4,
                                        height: 35.0,
                                        child: RaisedButton(
                                            color: Color(0xFF398FE2),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                            ),
                                            child: Text(
                                              '견적요청',
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onPressed: () {
                                              print('비교견적');
                                              if (_isLogin == 'true') {
                                                if (_userType == 'pro') {
                                                  Get.snackbar('Error',
                                                      '전문가는 견적요청을 할 수 없습니다\n고객 전환 후 이용해주세요');
                                                } else {
                                                  Get.toNamed(
                                                      "/order/true?id=$user_id&&type=com");
                                                }
                                              } else {
                                                Get.to(LoginPage());
                                              }
                                            }),
                                      )
                                    : ButtonTheme(
                                        minWidth: Get.width * 0.4,
                                        height: 35.0,
                                        child: RaisedButton(
                                            color: Color(0xFFe23963),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3.0),
                                            ),
                                            child: Text(
                                              '견적보기',
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onPressed: () {
                                              print('견적보기');
                                              Get.toNamed(
                                                  '/orderList/true?id=$_userId');
                                            }),
                                      )
                                : ButtonTheme(
                                    minWidth: Get.width * 0.4,
                                    height: 35.0,
                                    child: RaisedButton(
                                        color: Color(0xFF398FE2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3.0),
                                        ),
                                        child: Text(
                                          '시작하기',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          print('로그인');
                                          print(_ad);
                                          Get.to(LoginPage());
                                        }),
                                  ),
                            Spacer(),
                          ],
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              CarouselAd().isNull
                  ? SizedBox(
                      height: 10.0,
                      child: Text(""),
                    )
                  : SizedBox(
                      height: 120.0,
                      width: Get.width,
                      child: CarouselAd(),
                    ),
              Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 30.0,
                      height: 3.0,
                      color: Color(0xFF398FE2),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '전문가 추천 (시공사전예약)',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 13.0),
                        ),
                        SizedBox(
                          height: 50.0,
                          width: 100.0,
                          child: SelectFormField(
                            type: SelectFormFieldType
                                .dropdown, // or can be dialog
                            initialValue: '수도권',
                            style: TextStyle(fontSize: 12.0),
                            items: _items,
                            onChanged: (val) {
                              setState(() {
                                selected = val;
                              });
                              _getProRecom();
                              print('asd : $selected');
                            },
                            //onSaved: (val) => print(val),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
                height: 350.0,
                width: Get.width,
                color: Colors.white,
                child: _isLoading
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: _proUser.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                              onTap: () {
                                Get.toNamed(
                                    '/profilePPage/$_isLogin?id=${_proUser[index].user_id}');
                              },
                              child: Container(
                                height: 60.0,
                                margin: EdgeInsets.symmetric(vertical: 5.0),
                                width: Get.width,
                                child: Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        'http://211.110.1.58/film_pro_profile/${_proUser[index].profile_img}',
                                      ),
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${_proUser[index].skill}',
                                          style: TextStyle(
                                            fontSize: 10.0,
                                          ),
                                        ),
                                        Text(
                                          '${_proUser[index].com_name}',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '[전문가 인증]',
                                          style: TextStyle(
                                              fontSize: 10.0,
                                              color: Colors.grey),
                                        ),
                                        //Text('친환경 벽지 시공전문', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w500),)
                                      ],
                                    ),
                                  ],
                                ),
                                //     SizedBox(height: 10.0),
                              ));
                        })
                    : Container(),
              ),
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: Text('전체보기'),
                  onPressed: () {
                    Get.to(ProListPage());
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 20.0, bottom: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 30.0,
                      height: 3.0,
                      color: Color(0xFF398FE2),
                    ),
                    Text(
                      '협력업체등록',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 13.0),
                    ),
                  ],
                ),
              ),
              _isAdLoading
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          _isLoading
                              ? Container(
                                  height: 50.0,
                                  width: Get.width * 0.9,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5,
                                          color: Color(0xFFd4d4d4))),
                                  child: GestureDetector(
                                    onTap: () {
                                      _isLoading
                                          ? Get.toNamed(
                                              '/ad/true?ad_id=${_ad[0].ad_id}')
                                          : CircularProgressIndicator();
                                    },
                                    child: SizedBox(),
                                    // Image.asset('assets/images/yerim.png', width: Get.width*0.9, fit: BoxFit.fitHeight,),
                                  ))
                              : Container(),
                          SizedBox(
                            height: 15.0,
                          ),
                          _isLoading
                              ? Container(
                                  height: 50.0,
                                  width: Get.width * 0.9,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5,
                                          color: Color(0xFFd4d4d4))),
                                  child: GestureDetector(
                                    onTap: () {
                                      _isLoading
                                          ? Get.toNamed(
                                              '/ad/true?ad_id=${_ad[1].ad_id}')
                                          : CircularProgressIndicator();
                                    },
                                    child: _isLoading
                                        ? Image.network(
                                            '${_ad[1].ad_img}',
                                            width: Get.width * 0.9,
                                            fit: BoxFit.fitHeight,
                                          )
                                        : Text(''),
                                  ))
                              : Container(),
                          SizedBox(
                            height: 15.0,
                          ),
                          _isLoading
                              ? Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5,
                                          color: Color(0xFFd4d4d4))),
                                  child: GestureDetector(
                                    onTap: () {
                                      _isLoading
                                          ? Get.toNamed(
                                              '/ad/true?ad_id=${_ad[2].ad_id}')
                                          : CircularProgressIndicator();
                                    },
                                    child: _isLoading
                                        ? Image.network(
                                            '${_ad[2].ad_img}',
                                            width: Get.width * 0.9,
                                            fit: BoxFit.fitHeight,
                                          )
                                        : Text(''),
                                  ))
                              : Container(),
                          SizedBox(
                            height: 15.0,
                          ),
                          _isLoading
                              ? Container(
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5,
                                          color: Color(0xFFd4d4d4))),
                                  child: GestureDetector(
                                    onTap: () {
                                      _isLoading
                                          ? Get.toNamed(
                                              '/ad/true?ad_id=${_ad[3].ad_id}')
                                          : CircularProgressIndicator();
                                    },
                                    child: _isLoading
                                        ? Image.network(
                                            '${_ad[3].ad_img}',
                                            width: Get.width * 0.9,
                                            fit: BoxFit.fitHeight,
                                          )
                                        : Text(''),
                                  ))
                              : Container(),
                        ],
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 150.0,
              ),
              Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  width: Get.width,
                  height: Get.height * 0.5,
                  color: Color(0xFFf0f0f0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '사업자 정보',
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        '상호 : 공간 인테리어',
                        style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0),
                      ),
                      Text(
                        '대표 : 김진도',
                        style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0),
                      ),
                      Text(
                        '주소 : 서울특별시 구로구 경인로 89, 2',
                        style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0),
                      ),
                      Text(
                        '사업자등록번호 : 133-11-85339',
                        style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0),
                      ),
                      Text(
                        '통신판매업 : 2021-서울구로-2289',
                        style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0),
                      ),
                      Text(
                        '호스팅사업자 : 주식화사Cafe24',
                        style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '고객문의 대표전화 : 02-2625-3868',
                        style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0),
                      ),
                      Text(
                        '펙스 : 02-2625-3878',
                        style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0),
                      ),
                      Text(
                        '이메일 : apt9785@naver.com',
                        style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        '우리동네필름반장에서는 통신판매중개자 역할로 인테리어필름견적, 시공당사자가 아니며, 시공전문가가 제공하는 견적비용 및 공사시공 서비스에대해 일체 책임을 지지 않습니다',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      //Text('호스팅 서비스 사업자 : Cafe24 주식회사', style: TextStyle(color: Colors.black38, fontWeight: FontWeight.w600, fontSize: 11.0),),
                    ],
                  ))
            ],
          ),
        ),
      ),
      drawer: Drawer(
          child: Container(
        color: Colors.white,
        child: _isLogin == 'true'
            ? ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            children: <Widget>[
                              Spacer(),
                              _userType == 'pro'
                                  ? CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 0,
                                    )
                                  : CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(profile_image),
                                      radius: 35,
                                    ),
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            width: 25.0,
                          ),
                          Column(
                            children: <Widget>[
                              Spacer(),
                              _userType == 'pro'
                                  ? Text(
                                      '$_userId 님',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    )
                                  : Text(
                                      '$user_id 님',
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                '안녕하세요',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.grey,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  _userType == 'pro'
                      ? SizedBox(
                          height: Get.height * 0.58,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                  '직접시공 요청',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  Get.toNamed(
                                      '/dir_orderList/true?id=$_userId');
                                },
                              ),
                              ListTile(
                                title: Text(
                                  '견적 요청',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  Get.toNamed('/orderList/true?id=$_userId');
                                },
                              ),
                              ListTile(
                                title: Text(
                                  '채팅',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  Get.toNamed('/chatlist/true?pro_id=$_userId');
                                },
                              ),
                              ListTile(
                                title: Text(
                                  '포인트 충전',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  Get.toNamed('/pointPage/true?id=$_userId');
                                },
                              ),
                              ListTile(
                                title: Text(
                                  '마이페이지',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  Get.toNamed(
                                      '/proMyPage/$_isLogin?$_userType&&id=$_userId');
                                },
                              ),
                              ListTile(
                                title: Text(
                                  '공지사항',
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  Get.toNamed('/noti/');
                                },
                              ),
                              SizedBox(
                                height: 100.0,
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: <Widget>[
                            // ListTile(
                            //   title: Text(
                            //     '받은 견적서',
                            //     style: TextStyle(
                            //         fontSize: 13.0,
                            //         fontWeight: FontWeight.bold),
                            //   ),
                            //   onTap: () {
                            //     Get.toNamed('/customerList/true?id=$user_id');
                            //   },
                            // ),
                            ListTile(
                              title: Text(
                                '채팅',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                Get.toNamed('/chatlist/true?user_id=$user_id');
                              },
                            ),
                            ListTile(
                              title: Text(
                                '마이페이지',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                Get.toNamed(
                                    '/customerMyPage/$_isLogin?user_type=$_userType&&id=$user_id');
                              },
                            ),
                            ListTile(
                              title: Text(
                                '공지사항',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                Get.toNamed('/noti/');
                              },
                            ),
                            SizedBox(
                              height: 100.0,
                            ),
                          ],
                        ),
                  Row(
                    children: <Widget>[
                      Spacer(),
                      TextButton(
                        child: Text('로그아웃'),
                        onPressed: () {
                          print('로그아웃');
                          setState(() {
                            _isLogin = 'false';
                            _userId = 'null';
                          });
                          storage.delete(key: "login");
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Get.toNamed('/notice/true?sub=이용방법');
                        },
                        child: Text(
                          '이용방법',
                          style: TextStyle(fontSize: 13.0, color: Colors.grey),
                        ),
                      ),
                      Text(
                        '|',
                        style: TextStyle(fontSize: 13.0, color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed('/notice/true?sub=개인정보이용방침');
                        },
                        child: Text(
                          '개인정보이용방침',
                          style: TextStyle(fontSize: 13.0, color: Colors.grey),
                        ),
                      ),
                      Text(
                        '|',
                        style: TextStyle(fontSize: 13.0, color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed('/notice/true?sub=이용약관');
                        },
                        child: Text(
                          '이용약관',
                          style: TextStyle(fontSize: 13.0, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Spacer(),
                              Text(
                                '로그인해주세요',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                '안녕하세요\n신뢰와 믿음 안전을 위한 간편 로그인',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      height: Get.height * 0.65,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: Get.height * 0.15),
                            ElevatedButton(
                              child: Text(
                                '   로그인   ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue),
                              onPressed: () {
                                Get.to(LoginPage());
                              },
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed('/notice/true?sub=이용방법');
                                  },
                                  child: Text(
                                    '이용방법',
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.grey),
                                  ),
                                ),
                                Text(
                                  '|',
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.grey),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed('/notice/true?sub=개인정보이용방침');
                                  },
                                  child: Text(
                                    '개인정보이용방침',
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.grey),
                                  ),
                                ),
                                Text(
                                  '|',
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.grey),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed('/notice/true?sub=이용약관');
                                  },
                                  child: Text(
                                    '이용약관',
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.0,
                            )
                          ])),
                ],
              ),
      )),
    );
  }
}
