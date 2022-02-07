import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_film/datas/pro_select_data.dart';
import 'package:flutter_film/datas/select_rating_data.dart';
import 'package:flutter_film/models/pro_select_model.dart';
import 'package:flutter_film/models/select_rating_model.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/all.dart';

class ProfilePPage extends StatefulWidget{
  @override
  _ProfilePPageState createState() => _ProfilePPageState();
}

class _ProfilePPageState extends State<ProfilePPage>{

  String? pro_id;  //pro ID
  String? _isLogin;
  List<Pro_Select>? _proSelect;
  List<Select_Rating>? _ratingSelect;
  bool? _isLoading;
  bool? _isLoading2;
  
  @override
  void dispose(){
    super.dispose();
  }

  @override
  void initState(){
    _initTexts();
    print(user_id);
    _isLoading = false;
    _isLoading2 = false;
    _isLogin = Get.parameters['param'];
    pro_id = Get.parameters['id'];
    _proSelect = [];
    _ratingSelect = [];
    _getProSelect();
    _getRating();
    super.initState();
  }







  _getProSelect(){
    ProSelect_Data.getProSelect(pro_id!).then((proSelect){
      setState(() {
        _proSelect = proSelect;
      });
      if(proSelect.length == 0){
          _isLoading = false;
      }else{
          _isLoading = true;
      }
    });
  }
  
  _getRating(){
    SelectRating_Data.getRating(pro_id!).then((ratingSelect){
      setState(() {
        _ratingSelect = ratingSelect;
      });
      if(ratingSelect.length == 0){
        _isLoading2 = false;
      }else{
        _isLoading2 = true;
      }
    });
  }


  _initTexts() async{
    final User user = await UserApi.instance.me();
    setState(() {
      user_id = user.kakaoAccount!.email!;
    });
    print(user_id);
  }
  String user_id = 'None';
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Text('전문가', style:
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
      backgroundColor: Color(0xFFF0F0F0),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
        _isLoading!
        ?
        Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0,),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network('http://gowjr0771.cafe24.com/film_pro_profile/${_proSelect![0].profile_img}', height: 65.0, width: 65.0, fit: BoxFit.cover,),
                    ),
                    SizedBox(width: 20.0,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('필름 시공자', style: TextStyle(fontSize: 10.0,),),
                        SizedBox(height: 1.0,),
                        Text('${_proSelect![0].com_name}', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),),
                        SizedBox(height: 5.0,),
                        Row(
                          children: <Widget>[
                            Icon(Icons.star, color: Color(0xFFFEC107), size: 13.0,),
                            Text('${_ratingSelect!.length}', style: TextStyle(fontSize: 12.0),)
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    _isLogin == 'true'
                    ?
                    SizedBox(
                      width: 75.0,
                      height: 25.0,
                      child: ElevatedButton(
                        child: Text('신청하기', style:
                        TextStyle(
                            fontSize: 11.0,
                            color: Color(0xFF398FE2)
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
                          Get.toNamed("/order/true?id=${user_id}&type=dir&dir_pro_id=${pro_id}&pro_token=${_proSelect![0].pro_token}");
                        },
                      ),
                    )
                    :SizedBox(),
                  ],
                ),
              ),
              SizedBox(height: 10.0,),
              SizedBox(height: 10.0,),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    SizedBox(height: 10.0,),
                    Text('${_proSelect![0].introduce}', style:
                      TextStyle(
                          color: Colors.grey,
                          fontSize: 13.0
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text('기본정보', style:
                      TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Text('${_proSelect![0].basic}', style:
                      TextStyle(
                          color: Colors.grey,
                          fontSize: 13.0
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text('추가정보', style:
                      TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Text('${_proSelect![0].company}', style:
                      TextStyle(
                          color: Colors.grey,
                          fontSize: 13.0
                      ),
                    ),

                    SizedBox(height: 20.0),
                    Text('사진정보', style:
                      TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network('https://d-grab.co.kr/film_pro_info/${_proSelect![0].img1}', width: 130.0, height: 130.0, fit: BoxFit.cover,),
                            ),
                            SizedBox(width: 10.0,),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network('https://d-grab.co.kr/film_pro_info/${_proSelect![0].img2}', width: 130.0, height: 130.0, fit: BoxFit.cover,),
                            ),
                            SizedBox(width: 10.0,),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network('https://d-grab.co.kr/film_pro_info/${_proSelect![0].img3}', width: 130.0, height: 130.0, fit: BoxFit.cover,),
                            ),
                            SizedBox(width: 10.0,),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network('https://d-grab.co.kr/film_pro_info/${_proSelect![0].img4}', width: 130.0, height: 130.0, fit: BoxFit.cover,),
                            ),
                            SizedBox(width: 10.0,),ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network('https://d-grab.co.kr/film_pro_info/${_proSelect![0].img5}', width: 130.0, height: 130.0, fit: BoxFit.cover,),
                            ),
                            SizedBox(width: 10.0,),

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.0,),
              _isLoading2!
              ?
              Container(
                width: Get.width,
                height: Get.height*0.75,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('리뷰', style:
                          TextStyle(
                              color: Color(0XFF398FE2),
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0
                          ),
                          ),
                          SizedBox(height: 3.0,),
                          SizedBox(
                            child: Container(
                              width: 20.0,
                              height: 2.0,
                              color: Color(0XFF398FE2),
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          Row(
                            children: <Widget>[
                              Icon(Icons.star, color: Color(0xFFFEC107), size: 30.0,),
                              SizedBox(width: 5.0,),
                              Text('[${_ratingSelect!.length}]', style:
                                TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 17.0
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Spacer(),
                    Container(
                      height: Get.height*0.5,
                      width: Get.width,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount:
                        _ratingSelect!.length > 5
                          ? 5
                          : _ratingSelect!.length,
                        itemBuilder: (BuildContext context, int index){
                          return Container(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  width: Get.width,
                                  height: 0.3,
                                  child: Container(
                                    color: Colors.grey,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text('${_ratingSelect![index].user_id.substring(0,5)}****', style:
                                              TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.0
                                              ),
                                            ),
                                            SizedBox(width: 5.0,),
                                            Icon(Icons.star, color: Color(0xFFFEC107), size: 13.0,),
                                            SizedBox(width: 2.0,),
                                            Text('${_ratingSelect![index].rating}', style:
                                              TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13.0
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.0,),
                                        Text('${_ratingSelect![index].review}', style:
                                          TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 13.0
                                          ),
                                        )

                                      ]
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 100.0,
                        height: 40.0,
                        child: ElevatedButton(
                          child: Text('리뷰 더보기', style:
                          TextStyle(
                              fontSize: 13.0,
                              color: Color(0xFF398FE2),
                              fontWeight: FontWeight.w600
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
                            Get.toNamed('/review/true?id=${_proSelect![0].user_id}');
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                  ],
                ),
              )
              :
              Container(
                width: Get.width,
                height: Get.height*0.2,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.article, size: 50.0, color: Colors.grey,),
                    SizedBox(height: 20.0,),
                    Text('리뷰가 없습니다', style:
                      TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 20.0,),
            ],
          ),
        )
        :
        Container(
            height: Get.height*0.8,
            width: Get.width,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 200.0,
                width: Get.width,
                margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 0.2),
                    borderRadius: BorderRadius.circular(10.0)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.warning_outlined, size: 60.0, color: Colors.red,),
                    SizedBox(height: 2.0,),
                    Text('해당 전문가의 정보가 존재하지 않습니다. \n관리자에게 문의 또는 네트워크 상태를 확인하세요', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),
                    Spacer(),
                    ElevatedButton(
                        onPressed: (){
                          Get.back();
                        },
                        child:
                        Text('     돌아가기     ', style:
                          TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        )
                    ),
                    SizedBox(height: 15.0,)
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}