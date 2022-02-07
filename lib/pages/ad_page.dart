import 'package:flutter/material.dart';
import 'package:flutter_film/datas/ad_data.dart';
import 'package:flutter_film/models/ad_model.dart';
import 'package:get/get.dart';

class AdPage extends StatefulWidget{
  @override
  _AdPageState createState() => _AdPageState();
}

class _AdPageState extends State<AdPage>{

  String? ad_id;
  List<Ad>? _ad;
  bool? _isLoading;


  @override
  void initState(){
    super.initState();
    ad_id = Get.parameters['ad_id'];
    _isLoading = false;
    _ad = [];
    _getBanner();
  }

  _getBanner(){
    Ad_Data.getAd2(ad_id!).then((ad){
      setState(() {
        _ad = ad;
      });
      if(ad.length == 0){
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
        title: _isLoading! ? Text('${_ad![0].ad_text}', style:
        TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
        ):Text(''),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            width: Get.width,
            child: _isLoading! ?
            Column(
              children: <Widget>[
                _ad![0].ad_img.isNull?
                Text(''):Image.network('${_ad![0].ad_img}', width: Get.width, fit: BoxFit.fitWidth,),
                SizedBox(height: 15.0,),
                _ad![0].detail_txt.isNull?
                Text(''):Text('${_ad![0].detail_txt}', style: TextStyle(fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.w600),),
                SizedBox(height: 30.0,),
                _ad![0].detail_img.isNull?
                Text(''):Image.network('${_ad![0].detail_img}', width: Get.width, fit: BoxFit.fitWidth,),
              ],
            ):Container(child: Text(''),)
        ),
      ),
    );
  }
}