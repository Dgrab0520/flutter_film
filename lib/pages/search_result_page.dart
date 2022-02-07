import 'package:flutter/material.dart';
import 'package:flutter_film/datas/idpw_data.dart';
import 'package:flutter_film/models/idpw_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchResultPage extends StatefulWidget{
  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage>{
  List<SearchIDPW>? _searchID;
  List<SearchIDPW>? _searchPW;
  bool? _isLoading;
  String? searchType;
  String? user_ph;
  String? user_id;

  @override
  void initState(){
    super.initState();
    _isLoading = false;
    _searchID = [];
    _searchPW = [];
    searchType = Get.parameters['param'];
    user_ph = Get.parameters['user_phone'];
    user_id = Get.parameters['user_id'];
    _search_ID();
    _search_PW();
  }

  _search_ID(){
    SearchIDPW_Data.getSearchID(user_ph!).then((searchID){
      setState(() {
        _searchID = searchID;
      });
      if(searchID.length == 0){
        _isLoading = false;
      }else{
        _isLoading = true;
      }
    });
  }

  _search_PW(){
    SearchIDPW_Data.getSearchPW(user_id!, user_ph!).then((searchPW){
      setState(() {
        _searchPW = searchPW;
      });
      if(searchPW.length == 0){
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
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: Get.height*0.2,),

            Container(
              height: Get.height*0.7,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('전문가님이 찾으시는 $searchType는 ', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
                  searchType == "ID"
                      ?
                  Container(
                      height: Get.height*0.4,
                      width: Get.width*0.8,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: _searchID!.length,
                        itemBuilder: (BuildContext context, int index){
                          return Container(child: Text('${_searchID![index].user_id}', textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),);
                        }
                      ),
                  )
                      :
                  Container(
                      height: Get.height*0.4,
                      width: Get.width*0.8,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: _searchPW!.length,
                          itemBuilder: (BuildContext context, int index){
                            return Container(child: Text('${_searchPW![index].user_pw}', textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),);
                          }
                      )
                  ),
                ],
              ),
            ),
          ],
        )
      )
    );
  }
}