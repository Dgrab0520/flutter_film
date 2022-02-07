import 'package:flutter/material.dart';
import 'package:flutter_film/datas/update_ph_data.dart';
import 'package:get/get.dart';

class ChangePage extends StatefulWidget{
  @override
  _ChangePageState createState() => _ChangePageState();
}

class _ChangePageState extends State<ChangePage>{

  String? user_Ph;
  String? userId;
  TextEditingController phController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    user_Ph = Get.parameters['ph'];
    userId = Get.parameters['id'];
  }

  _updateIntro(){
    Update_PH_Data.updatePH(userId!, phController.text).then((result){
      if('success' == result){
        print('수정 완료');
        Get.back();
      }else{
        Get.snackbar("Error", '네트워크 상태를 확인해주세요');
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
        title: Text('휴대폰 변경', style:
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
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
            Text('휴대폰 번호 변경', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
            SizedBox(height: 20.0,),
            TextField(
              keyboardType: TextInputType.number,
              controller: phController,
              decoration: InputDecoration(
                fillColor: Color(0xFFF8F8F8),
                filled: true,
                labelText: '휴대폰 번호',
                labelStyle: TextStyle(fontSize: 11.0),
                hintText: "( -를 제외하고 입력해주세요 )",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0,),
            ElevatedButton(
                onPressed: (){
                  if(phController.text.isEmpty){
                    Get.snackbar("Error", "번호를 입력해주세요");
                  }else{
                    _updateIntro();
                  }

                },
                child: Text('  변경하기  ', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),))
          ],
        ),
      ),
    );
  }
}