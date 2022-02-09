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
import 'package:flutter_film/main.dart';
import 'package:flutter_film/models/chat_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'detailscreen.dart';

class Chat_Page extends StatefulWidget {
  @override
  _Chat_PageState createState() => _Chat_PageState();
}

class _Chat_PageState extends State<Chat_Page> {
  String? estimate_id = Get.parameters['estimate_id'];
  String? userId = Get.parameters['user_id'];
  String? com_name = Get.parameters['com_name'];
  String? isPro = Get.parameters['isPro'];
  int chatIndex = int.parse(Get.parameters['index']!);
  List<Chat> chatting = [];
  bool isChat = false;
  String? token = Get.parameters['token'];

  bool _isLoading = true;
  TextEditingController chatController = TextEditingController();
  ScrollController scrollController = ScrollController();

  FocusNode focusNode = FocusNode();

  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('sendFCM',
      options: HttpsCallableOptions(timeout: const Duration(seconds: 5)));

  @override
  void initState() {
    estimate_id = Get.parameters['estimate_id'];
    isChattingRoom = true;
    print(token);
    getChat();
    FirebaseMessaging.onMessage.listen((message) {
      getChat();
    });
    super.initState();
  }

  getChat() {
    ChatData.getChat(estimate_id!).then((value) {
      print(value);
      setState(() {
        chatting = value;
      });
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
            isPro == "Cus" ? com_name! : userId!.split("@")[0],
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
        backgroundColor: Color(0xFFffffff),
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
                                } else {
                                  return MyChat(
                                      text: chatting[index].text,
                                      createAt: chatting[index].createAt,
                                      isPro: chatting[index].isPro == isPro
                                          ? true
                                          : false);
                                }
                              }),
                        )),
                  ),
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
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
                              icon: Icon(
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
                                        estimateId: estimate_id!,
                                        estimate: "estimate",
                                        text: chatController.text,
                                        image: "",
                                        isPro: isPro!,
                                        createAt: "");

                                    ChatData.putChat(chat).then((value) async {
                                      print(value);
                                      if (value.isNotEmpty) {
                                        chat.createAt = value[0];

                                        estimate[chatIndex].createAt = value[0];
                                        estimate[chatIndex].chat =
                                            chatController.text;

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
                                        print(estimate[chatIndex].createAt);
                                        print(estimate[chatIndex].chat);
                                        final HttpsCallableResult result =
                                            await callable.call(
                                          <String, dynamic>{
                                            "token": token,
                                            "title": "채팅",
                                            "body": "메세지가 도착했습니다",
                                          },
                                        );
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
                            icon: Icon(
                              CupertinoIcons.photo_on_rectangle,
                            ),
                            onPressed: () async {
                              XFile? file = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              Chat chat = Chat(
                                  id: 0,
                                  estimateId: estimate_id!,
                                  estimate: "estimate",
                                  text: "",
                                  image: "true",
                                  isPro: isPro!,
                                  createAt: "");

                              ChatData.putChat(chat, file: File(file!.path))
                                  .then((value) async {
                                print(value);
                                if (value.isNotEmpty) {
                                  chat.createAt = value[0];
                                  chat.image = value[1];
                                  setState(() {
                                    chatting.insert(0, chat);
                                    estimate[chatIndex].createAt = value[0];
                                    estimate[chatIndex].chat = "";

                                    chatController.text = "";
                                    isChat = false;
                                    Timer(
                                        Duration(milliseconds: 200),
                                        () => scrollController.animateTo(0.0,
                                            duration:
                                                Duration(milliseconds: 300),
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
                                }
                              });
                            },
                          ),
                          contentPadding:
                              EdgeInsets.only(left: 5, top: 5, bottom: 5),
                          labelStyle: TextStyle(
                            fontSize: 12,
                          ),
                          border: InputBorder.none,
                        ),
                      ))
                ],
              )
            : Center(
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
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(width: 10),
              Container(
                constraints: BoxConstraints(maxWidth: Get.width / 2),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(
                      width: 1,
                      color: Color(0xFFcccccc),
                    )),
                child: Text(
                  text,
                  style: TextStyle(
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
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(width: 10),
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
