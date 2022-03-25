import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_film/datas/userCheck_data.dart';
import 'package:flutter_film/models/userCheck_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iamport_flutter/Iamport_certification.dart';
import 'package:iamport_flutter/model/certification_data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _userId;
  bool? _isLoading = false;
  List<User_Check>? _user_info;
  PickedFile? _image;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    _user_info = [];
    _userId = Get.parameters['id'];
    _getUserInfo();
  }

  _getUserInfo() {
    UserCheck_Data.getUserCheck(_userId!).then((user_info) {
      setState(() {
        _user_info = user_info;
      });
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

  Future getImageGallery() async {
    var imageFile =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = imageFile;
    });
    upload(File(_image!.path));
    print('getImageGallery Success');
  }

  Future upload(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("http://211.110.1.58/film_pro_profile.php");

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile("image", stream, length,
        filename: basename(imageFile.path));

    request.files.add(multipartFile);
    request.fields['pro_id'] = _userId!;

    var response = await request.send();

    if (response.statusCode == 200) {
      _getUserInfo();
      print('Image Uploaded');
    } else {
      print('Upload Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          '프로필 설정',
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
      backgroundColor: Color(0xFFf0f0f0),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: Get.width,
          child: _isLoading!
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Spacer(),
                          Stack(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Positioned(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                child: CircleAvatar(
                                  backgroundImage:
                                      // _image
                                      // ?
                                      NetworkImage(
                                    'http://211.110.1.58/film_pro_profile/${_user_info![0].profile_img}',
                                  ),
                                  // :
                                  // FileImage(File(_image.path)),
                                  backgroundColor: Colors.white,
                                  radius: 75,
                                ),
                              ),
                              Positioned(
                                  bottom: 1,
                                  right: 1,
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.camera_alt,
                                        size: 30.0,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        print('프로필 이미지 변경');
                                        getImageGallery();
                                      },
                                    ),
                                  )),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      width: Get.width,
                      color: Color(0xFFffffff),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '이름',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            _user_info![0].com_name,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      width: Get.width,
                      color: Color(0xFFffffff),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '이메일',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 5),
                          _user_info![0].user_email.isNull
                              ? Text('')
                              : Text(
                                  _user_info![0].user_email,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      color: Color(0xFFffffff),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '휴대전화',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '${_user_info![0].phone_number}',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            child: Text('변경하기'),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => Certification(
                                            type: 'PH',
                                            phone: _user_info![0].phone_number,
                                            id: _userId!,
                                          )));
                              //Get.offNamed('/changeph/true?id=$_userId&&ph=${_user_info[0].phone_number}');
                              print('핸드폰 변경');
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Column(
                      children: <Widget>[
                        GestureDetector(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          child: Container(
                            width: Get.width,
                            color: Color(0xFFffffff),
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 20.0),
                            child: Text(
                              '비밀번호 변경',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (context) => Certification(
                                          type: 'PW',
                                          phone: 'None',
                                          id: _userId!,
                                        )));
                            //Get.to();
                            print('비밀번호 변경');
                          },
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        // GestureDetector(
                        //   //crossAxisAlignment: CrossAxisAlignment.start,
                        //   child:Container(
                        //     width: Get.width,
                        //     color: Color(0xFFffffff),
                        //     padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                        //     child: Text(
                        //       '계정탈퇴',
                        //       style: TextStyle(
                        //         fontSize:14,
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        //     ),
                        //   ),
                        //   onTap: (){
                        //     //Get.to();
                        //     print('계정 탈퇴');
                        //   },
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    )
                  ],
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class Certification extends StatelessWidget {
  String type;
  String id;
  String phone;

  Certification({required this.type, required this.id, required this.phone});

  @override
  Widget build(BuildContext context) {
    return IamportCertification(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: new Text(
          '필름반장 본인인증',
          style: TextStyle(color: Colors.black, fontSize: 15.0),
        ),
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
        'merchantUid': 'mid_${DateTime.now().millisecondsSinceEpoch}', // 주문번호
        'company': '필름반장(공간인테리어)',
      }),
      /* [필수입력] 콜백 함수 */
      callback: (Map<String, String> result) {
        print('result : $result');
        if (type == "PH") {
          if (result['success'] == 'true') {
            Get.offNamed('/changeph/true?id=$id&&ph=$phone}');
          } else {
            Get.back();
          }
        } else if (type == "PW") {
          if (result['success'] == 'true') {
            Get.offNamed('/changepw/true?id=$id&&ph=$phone}');
          } else {
            Get.back();
          }
        }
      },
    );
  }
}
