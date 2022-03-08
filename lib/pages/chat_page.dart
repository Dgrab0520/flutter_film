import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_film/datas/chat_data.dart';
import 'package:flutter_film/datas/select_estimate_data.dart';
import 'package:flutter_film/datas/select_order_data.dart';
import 'package:flutter_film/main.dart';
import 'package:flutter_film/models/chat_model.dart';
import 'package:flutter_film/models/select_order_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'detailscreen.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}




class _ChatPageState extends State<ChatPage> {
  String? estimateId = Get.parameters['estimate_id'];

  String? userId = Get.parameters['user_id'];
  String? proId = Get.parameters['pro_id'];
  String? comName = Get.parameters['com_name'];
  String? isPro = Get.parameters['isPro'];
  String? order_id = Get.parameters['order_id'];
  int chatIndex = int.parse(Get.parameters['index']!);
  List<Chat> chatting = [];
  List<Select_Order> order = [];
  bool isChat = false;
  String? token = Get.parameters['token'];
  String condition = '';


  final bool _isLoading = true;
  TextEditingController chatController = TextEditingController();
  ScrollController scrollController = ScrollController();

  FocusNode focusNode = FocusNode();



  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('sendFCM',
      options: HttpsCallableOptions(timeout: const Duration(seconds: 5)));

  void sendFCM() async {
    List<String> tList = []; //메세지 보낼 사람 리스트
    String title = "[필름반장] 새로운 채팅이 도착했습니다";
    String body = "새로운 채팅을 확인해주세요";


    final HttpsCallableResult result = await callable.call(
      <String, dynamic>{
        "token": token,
        "title": title,
        "body": body,
      },
    ).whenComplete(() =>
        print("$token 에게 새로운 채팅 전달")
    );
    print(result.data);
  }

  final estimateController = Get.put(Estimate_Select_Data());

  @override
  void initState() {
    print('token : $token');
    estimateId = Get.parameters['estimate_id'];
    if(isPro == 'Cus'){
      setState(() {
        condition = "user_check = '2'";
      });
    }else{
      setState(() {
        condition = "pro_check = '2'";
      });
    }
    isChattingRoom = true;
    print(token);
    getChat();
    getOrder();
    FirebaseMessaging.onMessage.listen((message) {
      getChat();
    });
    checkMessage();
    super.initState();
  }

  getChat() {
    ChatData.getChat(estimateId!).then((value) {
      print(value);
      setState(() {
        chatting = value;
      });
    });
  }

  getOrder(){
    Order_Select_Data.getOrder(order_id!).then((value){
      setState(() {
        order = value;
      });
    });
  }

  checkMessage(){
    ChatData.updateCheck(estimateId!, condition, isPro!).then((value){
      if(value == 'success'){
        print('Update Check Success');
      }else {
        print('Update Check Fail');
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    chatController.dispose();
    scrollController.dispose();
    isChattingRoom = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1.0,
          title: Text(
            isPro == "Cus" ? comName! : userId!.split("@")[0],
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
              // isPro == 'Cus'
              // ? Get.offNamed('/chatlist/true?user_id=$userId')
              // : Get.offNamed('/chatlist/true?pro_id=$proId');
            },
          ),
          actions: [
            TextButton(onPressed: (){
              Get.defaultDialog(
                title: "요청서 확인",
                titleStyle: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500
                ),
                content: Container(
                  width: Get.width,
                  height: 200.0,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                            height: 200.0,
                            width: Get.width,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '서비스 희망 일자 : ${order[0].order_date}',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '서비스 지역 : ${order[0].service_area}',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Text(
                                      '서비스 크기 : ${order[0].service_size}',
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
                                    '${order[0].service_detail}',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black87),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: (){Get.back();},
                                    child: Container(
                                      height: 30.0,
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          color: Colors.blue
                                      ),
                                      child: Center(
                                        child: Text('확인',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                )
              );
            }, child: Text('요청서 확인'))
          ],
        ),
        backgroundColor: const Color(0xFFffffff),
        body: _isLoading
            ? Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 30),
                          child: ListView.builder(
                              controller: scrollController,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              reverse: true,
                              itemCount: chatting.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (chatting[index].image != "") {
                                  return ImageChat(
                                      image:
                                          "http://gowjr0771.cafe24.com/chat_image/${chatting[index].image}",
                                      createAt: chatting[index].createAt,
                                      isPro: chatting[index].isPro == isPro
                                          ? true
                                          : false);
                                }
                                else if(chatting[index].text != ""){
                                  return MyChat(
                                      text: chatting[index].text,
                                      createAt: chatting[index].createAt,
                                      isPro: chatting[index].isPro == isPro
                                          ? true
                                          : false
                                  );

                                }
                                else{
                                  return EstimateChat(
                                      estimate: chatting[index].estimate,
                                      createAt: chatting[index].createAt,
                                      isPro: chatting[index].isPro == isPro
                                          ? true
                                          : false,
                                    service_date: order[0].order_date,
                                    service_area: order[0].service_area,
                                    service_size: order[0].service_size,
                                    service_detail: order[0].service_detail,
                                  );
                                }
                              }),
                        )),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(width: 1.0, color: Colors.grey),
                          color: Colors.white),
                      child: TextField(
                        focusNode: focusNode,
                        textAlignVertical: TextAlignVertical.center,
                        controller: chatController,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 4,
                        onTap: () {},
                        onChanged: (text) {
                          setState(() {
                            if (text != "") {
                              isChat = true;
                            } else {
                              isChat = false;
                            }
                          });
                        },
                        decoration: InputDecoration(
                          suffixIcon: Transform.rotate(
                            angle: focusNode.hasFocus
                                ? isChat
                                    ? 90 * math.pi / 180
                                    : 180 * math.pi / 180
                                : 360 * math.pi / 180,
                            child: IconButton(
                              icon: const Icon(
                                CupertinoIcons.eject_fill,
                              ),
                              onPressed: () async {
                                if (chatController.text != "") {
                                  String text = chatController.text
                                      .replaceFirst(RegExp(r'^[\n, ]+'), "");

                                  if (text != "") {
                                    print('print');
                                    Chat chat = Chat(
                                        id: 0,
                                        estimateId: estimateId!,
                                        estimate: "estimate",
                                        text: chatController.text,
                                        image: "",
                                        isPro: isPro!,
                                        pro_check: isPro == "Cus" ? '1' : '2',
                                        user_check: isPro == "Cus" ? '2' : '1',
                                        createAt: "");

                                    ChatData.putChat(chat).then((value) async {
                                      print(value);
                                      if (value.isNotEmpty) {
                                        chat.createAt = value[0];
                                        estimateController.setCreateEstimate(
                                            chatIndex, value[0]);
                                        estimateController.setChatEstimate(
                                            chatIndex, chatController.text);

                                        setState(() {
                                          chatting.insert(0, chat);
                                          chatController.text = "";
                                          isChat = false;
                                          Timer(
                                              const Duration(milliseconds: 200),
                                              () => scrollController.animateTo(
                                                  0.0,
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.easeInOut));
                                        });
                                        sendFCM();
                                        // final HttpsCallableResult result =
                                        //     await callable.call(
                                        //   <String, dynamic>{
                                        //     "token": token,
                                        //     "title": "채팅",
                                        //     "body": "메세지가 도착했습니다",
                                        //   },
                                        // );
                                        // print(result.data);
                                      }
                                    });
                                  } else {
                                    chatController.text = "";
                                    FocusScope.of(context).unfocus();
                                  }
                                } else {
                                  if (focusNode.hasFocus) {
                                    FocusScope.of(context).unfocus();
                                  } else {
                                    focusNode.requestFocus();
                                  }
                                }
                              },
                            ),
                          ),
                          prefixIcon: IconButton(
                            icon: const Icon(
                              CupertinoIcons.photo_on_rectangle,
                            ),
                            onPressed: () async {
                              XFile? file = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              Chat chat = Chat(
                                  id: 0,
                                  estimateId: estimateId!,
                                  estimate: "estimate",
                                  text: "",
                                  image: "true",
                                  isPro: isPro!,
                                  pro_check: isPro == "Cus" ? '1' : '2',
                                  user_check: isPro == "Cus" ? '2' : '1',
                                  createAt: "");

                              ChatData.putChat(chat, file: File(file!.path)).then((value) async {
                                print(value);
                                if (value.isNotEmpty) {
                                  chat.createAt = value[0];
                                  chat.image = value[1];
                                  chat.pro_check = isPro == "Cus" ? '1' : '2';
                                  chat.pro_check = isPro == "Cus" ? '2' : '1';
                                  setState(() {
                                    chatting.insert(0, chat);
                                    estimateController.setCreateEstimate(
                                        chatIndex, value[0]);
                                    estimateController.setChatEstimate(
                                        chatIndex, "");

                                    chatController.text = "";
                                    isChat = false;
                                    Timer(
                                        const Duration(milliseconds: 200),
                                        () => scrollController.animateTo(0.0,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeInOut));
                                  });
                                  FocusScope.of(context).unfocus();
                                  final HttpsCallableResult result =
                                      await callable.call(
                                    <String, dynamic>{
                                      "token": token,
                                      "title": "채팅",
                                      "body": "메세지가 도착했습니다",
                                    },
                                  );
                                  print(result.data);
                                }
                              });
                            },
                          ),
                          contentPadding:
                              const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                          labelStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          border: InputBorder.none,
                        ),
                      ))
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

class MyChat extends StatelessWidget {
  const MyChat({
    Key? key,
    required this.text,
    required this.createAt,
    required this.isPro,
  }) : super(key: key);

  final String text;
  final String createAt;
  final bool isPro;

  @override
  Widget build(BuildContext context) {
    DateTime createAtTime = DateTime.parse(createAt);
    String time = DateFormat("HH:mm").format(createAtTime);
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        textDirection: isPro ? ui.TextDirection.ltr : ui.TextDirection.rtl,
        children: [
          Expanded(
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            textDirection: isPro ? ui.TextDirection.ltr : ui.TextDirection.rtl,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                constraints: BoxConstraints(maxWidth: Get.width / 2),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFcccccc),
                    )),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ImageChat extends StatelessWidget {
  const ImageChat({
    Key? key,
    required this.image,
    required this.createAt,
    required this.isPro,
  }) : super(key: key);

  final String image;
  final String createAt;
  final bool isPro;

  @override
  Widget build(BuildContext context) {
    DateTime createAtTime = DateTime.parse(createAt);
    String time = DateFormat("HH:mm").format(createAtTime);
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        textDirection: isPro ? ui.TextDirection.ltr : ui.TextDirection.rtl,
        children: [
          Expanded(
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            textDirection: isPro ? ui.TextDirection.ltr : ui.TextDirection.rtl,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  Get.to(DetailScreen(path: image));
                },
                child: Container(
                  constraints: BoxConstraints(maxWidth: Get.width / 2),
                  //padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Image.network(image),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class EstimateChat extends StatelessWidget{
  const EstimateChat({
    Key? key,
    required this.estimate,
    required this.createAt,
    required this.isPro,
    required this.service_date,
    required this.service_area,
    required this.service_size,
    required this.service_detail,
  }) : super(key: key);

  final String estimate;
  final String createAt;
  final bool isPro;
  final String service_date;
  final String service_area;
  final String service_size;
  final String service_detail;

  @override
  Widget build(BuildContext context) {
    DateTime createAtTime = DateTime.parse(createAt);
    String time = DateFormat("HH:mm").format(createAtTime);
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        textDirection: isPro ? ui.TextDirection.ltr : ui.TextDirection.rtl,
        children: [
          Expanded(
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            textDirection: isPro ? ui.TextDirection.ltr : ui.TextDirection.rtl,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  print('Estimate_chat');
                  // Get.to(DetailScreen(path: image));
                },
                child: Container(
                  constraints: BoxConstraints(maxWidth: Get.width*0.6),
                  //padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.3, color: Colors.grey),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        height: 30.0,
                        width: Get.width,
                        color: Color(0xFFCECECE),
                        child: Center(
                          child: Text("전문가 견적서", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.black87),),
                        ),
                      ),
                      SizedBox(height: 5.0,),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 15.0,),
                                Icon(CupertinoIcons.paperplane_fill, size: 17.0,),
                                Text("상세견적", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),),
                              ],
                            ),
                            SizedBox(height: 5.0,),
                            Container(
                              width: Get.width,
                              color: Color(0xFFE0E0FF),
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                              child: Text('$estimate'),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 15.0,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          height: 0.0,
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ),

                      SizedBox(height: 10.0,),
                      Container(
                        padding: EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '서비스 희망 일자 : $service_date',
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w300),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '서비스 지역 : $service_area',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '서비스 크기 : $service_size',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),


                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Container(

                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              width: Get.width,
                              height: 70.0,
                              color: Color(0xFFe6e6e6),
                              child: Text(
                                '$service_detail',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
