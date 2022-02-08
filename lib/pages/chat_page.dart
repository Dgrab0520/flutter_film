import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_film/datas/chat_data.dart';
import 'package:flutter_film/models/chat_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Chat_Page extends StatefulWidget {
  @override
  _Chat_PageState createState() => _Chat_PageState();
}

class _Chat_PageState extends State<Chat_Page> {
  String? estimate_id = Get.parameters['estimate_id'];
  String? userId = Get.parameters['user_id'];
  String? pro_id = Get.parameters['pro_id'];
  String? isPro = Get.parameters['isPro'];
  List<Chat> chatting = [];

  bool _isLoading = true;
  TextEditingController chatController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    estimate_id = Get.parameters['estimate_id'];
    print(isPro);
    getChat();
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
            isPro == "Cus" ? pro_id! : userId!.split("@")[0],
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
                                return MyChat(
                                    text: chatting[index].text,
                                    createAt: chatting[index].createAt,
                                    isPro: chatting[index].isPro == isPro
                                        ? true
                                        : false);
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
                        textAlignVertical: TextAlignVertical.center,
                        controller: chatController,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 4,
                        onTap: () {},
                        onChanged: (text) {},
                        // style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              CupertinoIcons.eject_fill,
                            ),
                            onPressed: () {
                              if (chatController.text != "") {
                                print('print');
                                Chat chat = Chat(
                                    id: 0,
                                    estimateId: estimate_id!,
                                    estimate: "estimate",
                                    text: chatController.text,
                                    image: "",
                                    isPro: isPro!,
                                    createAt: "");

                                ChatData.putChat(chat).then((value) {
                                  print(value);
                                  if (value.isNotEmpty) {
                                    chat.createAt = value[0];
                                    setState(() {
                                      chatting.insert(0, chat);

                                      chatController.text = "";
                                      Timer(
                                          Duration(milliseconds: 200),
                                          () => scrollController.animateTo(0.0,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.easeInOut));
                                    });
                                  }
                                });
                              }
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