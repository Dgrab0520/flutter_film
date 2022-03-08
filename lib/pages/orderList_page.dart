import 'package:flutter/material.dart';
import 'package:flutter_film/datas/pro_point_data.dart';
import 'package:flutter_film/datas/select_order_data.dart';
import 'package:flutter_film/models/pro_point_model.dart';
import 'package:flutter_film/models/select_order_model.dart';
import 'package:get/get.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  List<Select_Order>? _selectOrder;

  String? user_id;
  String? order_id;
  bool? _isLoading;
  List<Pro_Point>? _pro_point;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    user_id = Get.parameters['id'];
    _selectOrder = [];
    _pro_point = [];
    _getProPoint();
    _getSelectOrder();
    print('$user_id');
  }

  //견적서 불러오기
  _getSelectOrder() {
    Order_Select_Data.getOrderSelect(user_id!).then((selectOrder) {
      setState(() {
        _selectOrder = selectOrder;
      });
      _isLoading = true;
    });
  }

  _getProPoint() {
    ProPoint_Data.getProPoint(user_id!).then((pro_point) {
      setState(() {
        _pro_point = pro_point;
      });
      // if (pro_point.isEmpty) {
      //   _isLoading = false;
      // } else {
      //   setState(() {
      //     _isLoading = true;
      //   });
      // }
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
          '받은 견적서',
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
            Get.offAllNamed('/main/true?type=pro&&id=$user_id');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.wifi_protected_setup,
              color: Colors.black87,
            ),
            onPressed: () {
              _getSelectOrder();
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFFf0f0f0),
      body: SafeArea(
        child: _isLoading!
            ? _selectOrder!.isNotEmpty
                ? Container(
                    width: Get.width,
                    height: Get.height,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 30.0),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _selectOrder!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return LazyLoadingList(
                            initialSizeOfItems: 2,
                            index: index,
                            hasMore: true,
                            loadMore: () => print('Loading More'),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              padding: EdgeInsets.all(5.0),
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                //border: Border.all(width: _selectOrder[index].order_type == 'dir' ? 2.0 : 0.0, color: _selectOrder[index].order_type == 'dir' ? Colors.redAccent: Colors.white),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: const Offset(
                                      5.0,
                                      1.0,
                                    ),
                                    blurRadius: 10.0,
                                    spreadRadius: 1.0,
                                  )
                                ],
                              ),
                              child: Container(
                                  height: 200.0,
                                  width: Get.width,
                                  margin: EdgeInsets.symmetric(vertical: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'No.${_selectOrder![index].user_id}${_selectOrder![index].order_date}',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '작업 희망일',
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: 3.0,
                                          ),
                                          Text(_selectOrder![index]
                                              .service_date),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            '작업 지역',
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: 3.0,
                                          ),
                                          Text(_selectOrder![index]
                                              .service_area),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '작업 타입',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13.0),
                                          ),
                                          SizedBox(
                                            width: 3.0,
                                          ),
                                          Text(
                                            '${_selectOrder![index].service_type}',
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            '작업 크기 : ${_selectOrder![index].service_size}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13.0),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
                                          height: 50.0,
                                          width: Get.width,
                                          padding: EdgeInsets.all(3.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 0.5, color: Colors.grey),
                                          ),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Text(
                                              '${_selectOrder![index].service_detail}',
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          )),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.center,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              if (int.parse(
                                                      '${_pro_point![0].total_point}') >
                                                  1500) {
                                                Get.toNamed(
                                                    '/sendEstimate/true?user_id=${_selectOrder![index].user_id}&order_date=${_selectOrder![index].order_date}&order_id=${_selectOrder![index].order_id}&pro_id=$user_id&user_token=${_selectOrder![index].user_token}');
                                              } else {
                                                Get.snackbar("포인트 부족",
                                                    '포인트가 부족하여 견적을 보내지 못하였습니다. 충전 후 다시 이용 해주세요');
                                              }
                                            },
                                            child: Text(
                                              '견적서 보내기',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      )
                                    ],
                                  )),
                            ));
                      },
                    ))
                : const Center(
                    child: Text("받은 견적서가 없습니다"),
                  )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
