import 'package:flutter/material.dart';
import 'package:flutter_film/datas/order_ProList_data.dart';
import 'package:flutter_film/models/order_ProList_model.dart';
import 'package:get/get.dart';

class MatchingPage extends StatefulWidget {
  @override
  _MatchingPageState createState() => _MatchingPageState();
}

class _MatchingPageState extends State<MatchingPage> {
  String? order_date;
  String? user_id;
  String? order_id;
  String? pro_id;
  String? _isFin;
  List<Order_ProList>? _prolist;
  bool? _isLoading;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    user_id = Get.parameters['id'];
    order_date = Get.parameters['date'];
    _isFin = Get.parameters['_isFin'];
    order_id = Get.parameters['orderId'];
    print(order_id);
    _prolist = [];
    _isLoading = false;
    _getProList();
    super.initState();
  }

  _getProList() {
    Order_ProList_Data.getOrderProList(order_id!).then((prolist) {
      setState(() {
        _prolist = prolist;
      });
      if (prolist.length == 0) {
        _isLoading = false;
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
        title: Text(
          '전문가 매칭',
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
            Get.back();
          },
        ),
      ),
      backgroundColor: Color(0xFFF0F0F0),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 40.0,
              ),
              Container(
                  child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 1.0,
                    child: SizedBox(
                      width: 110.0,
                      height: 12.0,
                      child: Container(
                        color: Color(0xFF90BEEA),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Text(
                      '5명의 전문가를 추천해드려요',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                ],
              )),
              SizedBox(
                height: 3.0,
              ),
              Text(
                '전문가의 견적서를 확인해보세요',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w200,
                  color: Colors.grey,
                ),
              ),
              _isLoading!
                  ? Container(
                      height: Get.height * 0.75,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 30.0),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _prolist!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 15.0),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 180.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: Color(0xFF398FE2),
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffffffff),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                        '/profilePPage/true?id=${_prolist![index].pro_id}');
                                  },
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          'http://gowjr0771.cafe24.com/film_pro_profile/${_prolist![index].profile_img}',
                                        ),
                                        backgroundColor: Colors.white,
                                        radius: 25,
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
                                          Text('시공 전문가',
                                              style: TextStyle(
                                                fontSize: 10.0,
                                              )),
                                          Text('${_prolist![index].com_name}',
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w700)),
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          SizedBox(
                                              width: 75.0,
                                              height: 30.0,
                                              child: _isFin == '진행중'
                                                  ? ElevatedButton(
                                                      child: Text(
                                                        '의뢰하기',
                                                        style: TextStyle(
                                                            fontSize: 11.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0xFF398FE2)),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors.white,
                                                        side: BorderSide(
                                                          width: 1.0,
                                                          color:
                                                              Color(0xFF398FE2),
                                                        ),
                                                        elevation: 0.0,
                                                      ),
                                                      onPressed: () {
                                                        Get.toNamed(
                                                            '/sms/true?id=${_prolist![index].pro_id}&&order_id=$order_id&&user_id=$user_id');
                                                      },
                                                    )
                                                  : ElevatedButton(
                                                      child: Text(
                                                        '후기작성',
                                                        style: TextStyle(
                                                            fontSize: 11.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0xFF398FE2)),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors.white,
                                                        side: BorderSide(
                                                          width: 1.0,
                                                          color:
                                                              Color(0xFF398FE2),
                                                        ),
                                                        elevation: 0.0,
                                                      ),
                                                      onPressed: () {
                                                        Get.toNamed(
                                                            '/rating/true?user_id=${_prolist![index].user_id}&&pro_id=${_prolist![index].pro_id}');
                                                      },
                                                    )),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '견적 내용',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                    padding: EdgeInsets.all(5.0),
                                    height: 60.0,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.3, color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Text(
                                          '${_prolist![index].estimate_detail}'),
                                    )),
                                SizedBox(
                                  height: 3.0,
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    '${_prolist![index].estimate_date}',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black38),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ))
                  : Container(
                      width: Get.width,
                      height: Get.height * 0.6,
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 30.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.error,
                            size: 70.0,
                            color: Colors.red,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            '아직 전문가 견적이 도착하지 않았거나 네트워크 상태를 확인 해주세요',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFe68787)),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.redAccent),
                          ),
                        ],
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
