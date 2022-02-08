import 'package:flutter/material.dart';
import 'package:flutter_film/datas/userCheck_data.dart';
import 'package:flutter_film/models/userCheck_model.dart';
import 'package:get/get.dart';

class ProListPage extends StatefulWidget {
  @override
  _ProListPageState createState() => _ProListPageState();
}

class _ProListPageState extends State<ProListPage> {
  bool? _isLoading;
  List<User_Check>? _user_info;

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _user_info = [];
    _getUserInfo();
  }

  _getUserInfo() {
    UserCheck_Data.getUserALL().then((user_info) {
      setState(() {
        _user_info = user_info;
      });
      print(user_info.length);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          '전문가',
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
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
        color: Colors.white,
        child: _isLoading!
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _user_info!.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: () {
                        Get.toNamed(
                            '/profilePPage/true?id=${_user_info![index].user_id}');
                      },
                      child: Container(
                        height: 60.0,
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        width: Get.width,
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                'http://gowjr0771.cafe24.com/film_pro_profile/${_user_info![index].profile_img}',
                              ),
                              radius: 20,
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${_user_info![index].skill}',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                  ),
                                ),
                                Text(
                                  '${_user_info![index].com_name}',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '${_user_info![index].area1} / ${_user_info![index].area2}',
                                  style: TextStyle(
                                      fontSize: 10.0, color: Colors.grey),
                                ),
                                //Text('친환경 벽지 시공전문', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w500),)
                              ],
                            ),
                          ],
                        ),
                      ));
                })
            : Container(),
      ),
    );
  }
}
