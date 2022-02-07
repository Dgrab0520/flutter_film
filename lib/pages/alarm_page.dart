import 'package:flutter/material.dart';
import 'package:flutter_film/pages/profile_page.dart';
import 'package:flutter_film/pages/request_page.dart';


class AlarmPage extends StatefulWidget{
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

var _isChecked = true;

class _AlarmPageState extends State<AlarmPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Text('마이페이지', style:
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
      backgroundColor: Color(0xFFf0f0f0),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget> [
                SizedBox(height:15),
                Container(
                  padding:const EdgeInsets.only(left:20,right: 20.0),
                  width: MediaQuery.of(context).size.width,
                  height:70,
                  color: Color(0xFFffffff),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                      Text(
                        '앱푸시',
                        style: TextStyle(
                          fontSize: 16,
                        ),

                      ),
                      Switch(
                        value: _isChecked,
                        onChanged: (value){
                          setState(() {
                            _isChecked = value ;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                Container(
                  padding:const EdgeInsets.only(left:20,right: 20.0),
                  width: MediaQuery.of(context).size.width,
                  height:70,
                  color: Color(0xFFffffff),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                      Text(
                        '이메일',
                        style: TextStyle(
                          fontSize: 16,
                        ),

                      ),
                      Switch(
                        value: _isChecked,
                        onChanged: (value){
                          setState(() {
                            _isChecked = value ;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                Container(
                  padding:const EdgeInsets.only(left:20,right: 20.0),
                  width: MediaQuery.of(context).size.width,
                  height:70,
                  color: Color(0xFFf0f0f0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '소식 알리미',
                            style: TextStyle(
                              fontSize:16,
                            ),
                          ),
                          Text(
                            '프로모션, 업데이트 등 소식을 받아보세요',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: _isChecked,
                        onChanged: (value){
                          setState(() {
                            _isChecked = value ;
                          });
                        },
                      ),
                    ],
                  ),
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}