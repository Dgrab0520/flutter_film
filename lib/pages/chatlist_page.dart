import 'package:flutter/material.dart';
import 'package:flutter_film/datas/select_estimate_data.dart';
import 'package:flutter_film/models/select_estimate_model.dart';
import 'package:get/get.dart';

class Chatlist_Page extends StatefulWidget {
  @override
  _Chatlist_PageState createState() => _Chatlist_PageState();
}

class _Chatlist_PageState extends State<Chatlist_Page> {
  List<Select_Estimate> estimate = [
    Select_Estimate(
        order_id: "order_id",
        estimate_id: "주문번호",
        user_id: "고객",
        pro_id: "전문가",
        estimate_detail: "estimate_detail",
        count: "count")
  ];
  String? pro_id = Get.parameters['pro_id'];
  bool _isLoading = true;

  getEstimate() {
    Estimate_Select_Data.getProEstimate(pro_id!).then((value) {
      setState(() {
        estimate = value;
      });
      if (value.isEmpty) {
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
  void initState() {
    pro_id = Get.parameters['pro_id'];
    //getEstimate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          '채팅',
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
      body: Container(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.0),
                height: Get.height * 0.91,
                width: Get.width,
                child: _isLoading
                    ? ListView.builder(
                        itemCount: estimate.length,
                        itemBuilder: (_, int index) {
                          return InkWell(
                            onTap: () {
                              print('${estimate[index].user_id}');
                              Get.toNamed(
                                  '/chat/true?estimate_id=${estimate[index].estimate_id}');
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  width: Get.width,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      Text("${estimate[index].user_id}"),
                                      Text("${estimate[index].pro_id}"),
                                      Text("${estimate[index].estimate_id}"),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 0.1,
                                  thickness: 0.5,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          );
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
