import 'package:flutter/material.dart';
import 'package:flutter_film/datas/update_ph_data.dart';
import 'package:get/get.dart';


class ChangePW_Page extends StatefulWidget{
  @override
  _ChangePW_PageState createState() => _ChangePW_PageState();
}

class _ChangePW_PageState extends State<ChangePW_Page>{
  String? pro_id;
  TextEditingController pwController = new TextEditingController();
  TextEditingController newController = new TextEditingController();
  TextEditingController newCheckController = new TextEditingController();
  bool _ispwCheck = false;
  bool _ispwLength = false;

  @override
  void initState() {
    super.initState();
    pro_id = Get.parameters['id'];
  }


  // 조건 걸어서 _updatePW 실행되게끔 부터 시작하면 됨!!!!
  _udpatePW(){
    Update_PH_Data.updatePW(pro_id!, newController.text, pwController.text).then((result){
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Text('비밀번호 변경', style:
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
            Text('비밀번호 변경', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
            SizedBox(height: 20.0,),
            TextField(
              controller: pwController,
              obscureText: true,
              decoration: InputDecoration(
                fillColor: Color(0xFFF8F8F8),
                filled: true,
                labelText: '현재 비밀번호',
                labelStyle: TextStyle(fontSize: 11.0),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0,),
            TextField(
              controller: newController,
              obscureText: true,
              onChanged: (String value){
                if(value.toString() == newCheckController.text && value.length > 9){
                  setState(() {
                    _ispwCheck = true;
                    _ispwLength = true;
                  });
                }else{
                  setState(() {
                    _ispwCheck = false;
                    _ispwLength = false;
                  });
                }
              },
              decoration: InputDecoration(
                fillColor: Color(0xFFF8F8F8),
                filled: true,
                labelText: '새로운 비밀번호',
                labelStyle: TextStyle(fontSize: 11.0),
                border: OutlineInputBorder(),
              ),
            ),
            Text('비밀번호는 10글자 이상으로 설정해야 합니다', style: TextStyle(color: Colors.black38, fontSize: 12.0),),
            SizedBox(height: 20.0,),
            TextField(
              controller: newCheckController,
              obscureText: true,
              onChanged: (String value){
                if(value.toString() == newController.text && value.length > 9){
                  setState(() {
                    _ispwCheck = true;
                    _ispwLength = true;
                  });
                }else{
                  setState(() {
                    _ispwCheck = false;
                    _ispwLength = false;
                  });
                }
              },
              decoration: InputDecoration(
                fillColor: Color(0xFFF8F8F8),
                filled: true,
                labelText: '비밀번호 확인',
                labelStyle: TextStyle(fontSize: 11.0),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 3.0,),
            _ispwCheck
                ?
            Text('비밀번호가 일치합니다.', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),)
                :
            Text('비밀번호가 일치하지 않습니다.', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),),
            SizedBox(height: 20.0,),
            ElevatedButton(
                onPressed: (){
                  if(pwController.text.isEmpty){
                    Get.snackbar("Error", "비밀번호를 입력해주세요");
                  }else{
                    if(_ispwCheck){
                      _udpatePW();
                    }else{
                      Get.snackbar("Error", "비밀번호가 일치하지 않습니다");
                    }
                  }

                },
                child: Text('  변경하기  ', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),))
          ],
        ),
      ),
    );
  }
}