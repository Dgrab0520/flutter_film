import 'package:flutter/material.dart';
import 'package:flutter_film/datas/customerlist_data.dart';
import 'package:flutter_film/datas/update_order_status_data.dart';
import 'package:flutter_film/models/customerlist_model.dart';
import 'package:get/get.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';

class CustomerOrderListPage extends StatefulWidget {
  @override
  _CustomerOrderListPageState createState() => _CustomerOrderListPageState();
}

class _CustomerOrderListPageState extends State<CustomerOrderListPage> {
  String? user_id;
  List<Customer_List>? _customerList;
  String? order_date;
  String? _isFin;
  bool? _isLoading;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isFin = "진행중";
    _isLoading = false;
    user_id = Get.parameters['id'];
    _customerList = [];
    _getCustomerList();
  }

  _getCustomerList() {
    CustomerList_Data.getCustomerList(user_id!, _isFin!).then((customerList) {
      print(customerList);
      setState(() {
        _customerList = customerList;
      });
      if (customerList.isEmpty) {
        _isLoading = false;
      } else {
        setState(() {
          _isLoading = true;
        });
      }
    });
  }

  _updateOrderStatus() {
    UpdateOrderStatus_Data.updateOrderStatus(user_id!, order_date!)
        .then((result) {
      if ('success' == result) {
        print('삭제완료');
        _getCustomerList();
      } else {
        print('네트워크 에러');
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
            Get.back();
          },
        ),
      ),
      backgroundColor: Color(0xFFf0f0f0),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isFin = "진행중";
                              });
                              _getCustomerList();
                              print(_isFin);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: _isFin == "종료"
                                    ? Colors.grey
                                    : Colors.orangeAccent),
                            child: Text(
                              '진행중인 견적',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isFin = "종료";
                              });
                              _getCustomerList();
                              print(_isFin);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: _isFin == "종료"
                                    ? Colors.orangeAccent
                                    : Colors.grey),
                            child: Text(
                              '완료된 견적',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  )),
              _isLoading!
                  ? Container(
                      width: Get.width,
                      height: Get.height * 0.8,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _customerList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return LazyLoadingList(
                              initialSizeOfItems: 2,
                              index: index,
                              hasMore: true,
                              loadMore: () => print('Loading More'),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                padding: EdgeInsets.all(5.0),
                                width: Get.width,
                                height: 250.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 5.0),
                                    height: 100.0,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
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
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              '서비스 희망 일자 : ${_customerList![index].service_date}',
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            _isFin == "진행중"
                                                ? TextButton(
                                                    onPressed: () {
                                                      Get.defaultDialog(
                                                          title: '작업 완료',
                                                          titleStyle: TextStyle(
                                                              fontSize: 15.0,
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                              Text(
                                                                '작업이 완료된 경우, 완료하기를 클릭하여 전문가 후기를 작성해주세요',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .black54),
                                                              ),
                                                              SizedBox(
                                                                height: 20.0,
                                                              ),
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        print(
                                                                            'Cancel');
                                                                        Get.back();
                                                                      },
                                                                      child: Text(
                                                                          'Cancel'),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10.0,
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          order_date =
                                                                              "${_customerList![index].order_date}";
                                                                          _isFin =
                                                                              "종료";
                                                                        });
                                                                        print(
                                                                            order_date);
                                                                        print(
                                                                            user_id);
                                                                        _updateOrderStatus();
                                                                        Get.back();
                                                                      },
                                                                      child: Text(
                                                                          'Next'),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ));
                                                    },
                                                    child: Text(
                                                      '완료하기',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ))
                                                : TextButton(
                                                    onPressed: () {},
                                                    child: Text(''),
                                                  )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              '서비스 지역 : ${_customerList![index].service_area}',
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            Text(
                                              '서비스 크기 : ${_customerList![index].service_size}',
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          '서비스 내용',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.redAccent),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5.0),
                                          width: Get.width,
                                          height: 70.0,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              border: Border.all(
                                                  width: 0.4,
                                                  color: Colors.redAccent)),
                                          child: Text(
                                            '${_customerList![index].service_detail}',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black87),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        _isFin == "진행중"
                                            ? Align(
                                                alignment: Alignment.center,
                                                child: ElevatedButton(
                                                    child: Text(
                                                      '    견적보기    ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onPressed: () {
                                                      Get.toNamed(
                                                          '/matching/true?id=${_customerList![index].user_id}&&date=${_customerList![index].order_date}&&_isFin=$_isFin&&orderId=${_customerList![index].orderId}');
                                                    }),
                                              )
                                            : Align(
                                                alignment: Alignment.center,
                                                child: ElevatedButton(
                                                    child: Text(
                                                      '    후기작성    ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onPressed: () {
                                                      Get.toNamed(
                                                          '/matching/true?id=${_customerList![index].user_id}&&date=${_customerList![index].service_date}&&orderId=${_customerList![index].orderId}');
                                                    }),
                                              ),
                                      ],
                                    )),
                              ));
                        },
                      ))
                  : Container(),
            ],
          )),
    );
  }
}
