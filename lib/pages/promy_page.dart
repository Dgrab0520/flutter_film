import 'package:flutter/material.dart';
import 'package:flutter_film/datas/userCheck_data.dart';
import 'package:flutter_film/models/userCheck_model.dart';
import 'package:flutter_film/pages/alarm_page.dart';
import 'package:flutter_film/pages/profile_page.dart';
import 'package:flutter_film/pages/request_page.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/all.dart';


class ProMyPage extends StatefulWidget{
  @override
  _ProMyPageState createState() => _ProMyPageState();
}

class _ProMyPageState extends State<ProMyPage>{

  String? _userId;
  String? _userType;
  String? _isLogin;
  bool? _isLoading;
  List<User_Check>? _user_info;

  @override
  void initState(){
    _userType = Get.parameters['user_type'];
    _userId = Get.parameters['id'];
    _isLogin = Get.parameters['param'];
    _isLoading = false;
    _getUserInfo();
    super.initState();
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
        title: Text('마이페이지', style:
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
        actions: [
          IconButton(
              icon: Icon(Icons.settings, color: Colors.black54, size: 25.0,),
              onPressed: (){Get.toNamed('/profilePage/$_isLogin?id=$_userId');}
          )
        ],
      ),
      backgroundColor: Color(0xFFf0f0f0),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: Get.width,
          child: Column(
              children: <Widget> [
                SizedBox(height:15),
                _isLoading!
                ?
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
                          CircleAvatar(
                            backgroundImage: NetworkImage('http://gowjr0771.cafe24.com/film_pro_profile/${_user_info![0].profile_img}',),
                            backgroundColor: Colors.white,
                            radius: 45,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _user_info![0].com_name,
                            style: TextStyle(
                              fontSize:16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height:5),
                          Text('$_userId'),
                        ],
                      ),
                      SizedBox(width:10),
                      IconButton(
                          icon: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 25.0,),
                          onPressed: (){
                            Get.toNamed('/profilePEditPage/$_isLogin?id=$_userId');
                          }
                      ),
                    ],
                  ),
                )
                : CircularProgressIndicator(),
                SizedBox(height:15),
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
                            '사용자 이력',
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
                    Get.toNamed('/request/true?id=$_userId');
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
                            Icon(Icons.list_alt_outlined, color: Color(0xFF707070), size: 20.0,),
                            SizedBox(width:10),
                            Text(
                              '보낸 견적서',
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

                GestureDetector(
                  onTap: (){
                    Get.toNamed('/deposit/:true?pro_id=$_userId');
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
                            Icon(Icons.attach_money, color: Color(0xFF707070), size: 20.0,),
                            SizedBox(width:10),
                            Text(
                              '포인트',
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
                SizedBox(height:15),



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