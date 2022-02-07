import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_film/datas/select_estimate_data.dart';
import 'package:flutter_film/models/select_estimate_model.dart';
import 'package:get/get.dart';

class Chat_Page extends StatefulWidget{
  @override
  _Chat_PageState createState() => _Chat_PageState();
}

class _Chat_PageState extends State<Chat_Page>{

  String? estimate_id = Get.parameters['estimate_id'];
  List<Select_Estimate> estimate = [];
  bool _isLoading = false;


  @override
  void initState(){
    estimate_id = Get.parameters['estimate_id'];
    getEstimate();
    super.initState();
  }


  getEstimate(){
    Estimate_Select_Data.getChatEstimate(estimate_id!).then((value){
      setState(() {
        estimate = value;
      });
      if(value.length == 0){
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
    return GestureDetector(
      onTap: (){FocusScope.of(context).unfocus();},
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1.0,
          title: Text('${estimate[0].user_id}'.split("@")[0], style:
          TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
          ),
          leading: IconButton(icon: Icon(Icons.close, color: Colors.black,), onPressed: (){Get.back();},),
        ),
        backgroundColor: Color(0xFFffffff),
        body: _isLoading ? SingleChildScrollView(
          child: Container(
            height: Get.height*0.92,
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 14,
                  child: Container(
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.0,),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(width: 1.0, color: Colors.grey),
                            color: Colors.white
                        ),
                        child: Center(
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 4,
                            onTap: () {},
                            onChanged: (text) {},
                            // style: TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              suffixIcon: IconButton(icon: Icon(CupertinoIcons.eject_fill), onPressed: (){print('print');},),  //tray, text~
                              contentPadding: EdgeInsets.only(bottom: 2, top: 2),
                              labelStyle: TextStyle(
                                fontSize: 12,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        )
                      ),
                    )
                )
              ],
            ),
          ),
        ) : Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}