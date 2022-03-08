import 'package:flutter/material.dart';
import 'package:flutter_film/datas/userCheck_data.dart';
import 'package:flutter_film/models/userCheck_model.dart';
import 'package:flutter_film/pages/alarm_page.dart';
import 'package:flutter_film/pages/profile_page.dart';
import 'package:flutter_film/pages/request_page.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/all.dart';


class CustomerMyPage extends StatefulWidget{
  @override
  _CustomerMyPageState createState() => _CustomerMyPageState();
}

class _CustomerMyPageState extends State<CustomerMyPage>{


  String? _userType;
  String? _isLogin;
  bool? _isLoading;
  List<User_Check>? _user_info;

  @override
  void initState(){
    _initTexts();
    print(user_id);
    _userType = Get.parameters['user_type'];
    _isLogin = Get.parameters['param'];
    _isLoading = false;
    super.initState();
  }

  //카카오 로그인 고객
  _initTexts() async{
    final User user = await UserApi.instance.me();
    setState(() {
      user_id = user.kakaoAccount!.email!;
      _default_Image = user.kakaoAccount!.profile!.isDefaultImage!;
      profile_image = user.kakaoAccount!.profile!.profileImageUrl!;
    });
  }

  String user_id = 'None';
  String profile_image = 'None';
  bool _default_Image = true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Text('마이페이지', style:
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
      backgroundColor: Color(0xFFf0f0f0),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: Get.width,
          child: Column(
            children: <Widget> [
              SizedBox(height:15),
              Container(
                padding:const EdgeInsets.only(left:20,right: 20.0),
                width: Get.width,
                height:150,
                color: Color(0xFFffffff),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(profile_image),
                            radius: 50,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${user_id}',
                          style: TextStyle(
                            fontSize:15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height:5),
                      ],
                    ),
                    SizedBox(width:10),
                  ],
                ),
              ),
              SizedBox(height:15),
              // Container(
              //   padding:const EdgeInsets.only(left:20,right: 20.0),
              //   width: Get.width,
              //   height:50,
              //   color: Color(0xFFffffff),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: <Widget> [
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Text(
              //             '거래내역',
              //             style: TextStyle(
              //               fontSize:16,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // GestureDetector(
              //   onTap: (){
              //     Get.toNamed('/customerList/true?id=$user_id');
              //     print('success');
              //   },
              //
              //   child: Container(
              //     padding:const EdgeInsets.only(left:20,right: 20.0),
              //     width: Get.width,
              //     height:50,
              //     color: Color(0xFFffffff),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: <Widget> [
              //         Row(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Icon(Icons.list_alt_outlined, color: Color(0xFF707070), size: 20.0,),
              //             SizedBox(width:10),
              //             Text(
              //               '받은 견적서', style:
              //               TextStyle(
              //                 fontSize:15,
              //               ),
              //             ),
              //           ],
              //         ),
              //         Row(
              //           children: [
              //             Icon(Icons.arrow_forward_ios, color: Color(0xFF707070), size: 20.0,),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Container(
                padding:const EdgeInsets.only(left:20,right: 20.0),
                width: Get.width,
                height:50,
                color: Color(0xFFffffff),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '설정',
                          style: TextStyle(
                            fontSize:16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AlarmPage())
                  );
                  print('success');
                },
                child: Container(
                  padding:const EdgeInsets.only(left:20,right: 20.0),
                  width: Get.width,
                  height:50,
                  color: Color(0xFFffffff),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.notifications_none_sharp, color: Colors.grey, size: 25.0,),
                          SizedBox(width:10),
                          Text(
                            '알림',
                            style: TextStyle(
                              fontSize:15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.arrow_forward_ios, color: Color(0xFF707070), size: 20.0,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}