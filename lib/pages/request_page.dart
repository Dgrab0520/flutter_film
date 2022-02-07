import 'package:flutter/material.dart';
import 'package:flutter_film/datas/get_estimate_data.dart';
import 'package:flutter_film/models/get_estimate_model.dart';
import 'package:flutter_film/pages/deposit_page.dart';
import 'package:get/get.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';


class RequestPage extends StatefulWidget {

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {

  String? pro_id;
  List<Estimate_Info>? _estimateInfo;
  bool? _isLoading;

  @override
  void dispose(){
    super.dispose();
  }

  @override
  void initState(){
    _isLoading = false;
    pro_id = Get.parameters['id'];
    _getEstimateInfo();
    super.initState();
  }

  _getEstimateInfo(){
    Estimate_Info_Data.getEstimateInfo(pro_id!).then((estimateInfo){
      setState(() {
        _estimateInfo = estimateInfo;
      });
      if(estimateInfo.length == 0){
        _isLoading = false;
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
        title: Text('보낸 견적', style:
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
        Column(
          children: <Widget>[
            SizedBox(height: 15.0),
            Row(
              children: <Widget>[
                SizedBox(width: 10.0,),
                Icon(Icons.arrow_right, size: 20.0,),
                SizedBox(width: 1.0,),
                Text(
                  '견적 내역 [${_estimateInfo!.length}]',
                  style: TextStyle(
                    fontSize:15,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            Container(
                width: Get.width,
                height: Get.height*0.85,
                child:
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _estimateInfo!.length,
                  itemBuilder: (BuildContext context, int index){
                    return LazyLoadingList(
                        initialSizeOfItems: 5,
                        index: index,
                        hasMore: true,
                        loadMore: () => print('Loading More'),
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            //padding: EdgeInsets.all(5.0),
                            width: Get.width,
                            child: Column(
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[

                                            //SizedBox(height: 40.0,),
                                            Container(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[

                                                    Container(
                                                      padding:const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                                                      width: MediaQuery.of(context).size.width,
                                                      height: 150,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(width: 0.5, color: Color(0xFF707070)), // 박스 테두리 만들기
                                                        borderRadius: BorderRadius.circular(10), //박스 둥글게 만들기
                                                      ),
                                                      child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Text(
                                                                  '견적발송 > ${_estimateInfo![index].user_id}',
                                                                  style: TextStyle(
                                                                    fontSize:16,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: Get.width,
                                                                  height: 60.0,
                                                                  padding: EdgeInsets.all(4.0),
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                    color: Color(0xFFf5f5f5)
                                                                  ),
                                                                  child: Text(
                                                                    '${_estimateInfo![index].estimate_detail}',
                                                                    overflow: TextOverflow.ellipsis,
                                                                    maxLines: 3,
                                                                    style: TextStyle(
                                                                      fontSize:13,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(height:10),
                                                                Text(
                                                                  '${_estimateInfo![index].estimate_date}',
                                                                  style: TextStyle(
                                                                    fontSize:14,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                    ),
                                                    SizedBox(height:5),

                                                  ],
                                                )
                                            )
                                          ]
                                      )
                                  )
                                ]
                            )
                        )
                    );
                  },
                )
            ),
          ],
        )
        : Container(
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
                    Text('네트워크 상태를 확인하세요', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),
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
        )
      )
    );
  }
}
