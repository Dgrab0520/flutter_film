import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_film/datas/select_noti_data.dart';
import 'package:flutter_film/models/select_noti_model.dart';
import 'package:get/get.dart';

class NotiPage extends StatefulWidget{
  @override
  _NotiPageState createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage>{

  List<Select_Noti>? _selectnoti;
  bool? _isLoading;

  @override
  void initState(){
    super.initState();
    _isLoading = false;
    _selectnoti = [];
    _getNoti();
  }

  _getNoti(){
    Noti_Select_Data.getNotiSelect().then((selectnoti){
      setState(() {
        _selectnoti = selectnoti;
      });
      if(selectnoti.length == 0){
        _isLoading = false;
      }else{
        _isLoading = true;
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
        title: Text('공지사항', style:
        TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black,),
          onPressed: (){
            Get.back();
          },
        ),
      ),
      backgroundColor: Color(0xFFf2f2f2),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: Get.height,
          width: Get.width,
          child: _isLoading!
              ?
          ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            scrollDirection: Axis.vertical,
            itemCount: _selectnoti!.length,
            itemBuilder: (BuildContext context, int index){
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: Get.width,
                    color: Colors.white,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Icon(Icons.warning_amber_outlined),
                        ),
                        SizedBox(width:15.0,),
                        Expanded(
                          flex: 9,
                          child: ExpandablePanel(
                              theme: const ExpandableThemeData(
                                headerAlignment: ExpandablePanelHeaderAlignment.center,
                              ),
                              header: Text('${_selectnoti![index].notice_title}', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                              collapsed: Text('${_selectnoti![index].notice_content}', style: TextStyle(fontSize: 16.0), softWrap: true, overflow: TextOverflow.ellipsis,),
                              expanded: Text('${_selectnoti![index].notice_content}', softWrap: true, style: TextStyle(fontSize: 16.0), ),
                          ),
                        ),
                        SizedBox(width: 10.0,),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                ],
              );
            }
          )
          :Container(child: Text(''),),
        ),
      )
    );
  }
}