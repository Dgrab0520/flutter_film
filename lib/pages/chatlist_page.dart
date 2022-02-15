import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_film/datas/select_estimate_data.dart';
import 'package:flutter_film/main.dart';
import 'package:flutter_film/models/select_estimate_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Chatlist_Page extends StatefulWidget {
  @override
  _Chatlist_PageState createState() => _Chatlist_PageState();
}

class _Chatlist_PageState extends State<Chatlist_Page> {
  String? pro_id = Get.parameters['pro_id'];
  String? user_id = Get.parameters['user_id'];
  bool _isLoading = true;
  String isPro = "Cus";

  getEstimate() {
    Estimate_Select_Data.getProEstimate(pro_id!).then((value) {
      print(value);
      setState(() {
        estimate = value;
        if (value.isEmpty) {
          _isLoading = false;
        } else {
          _isLoading = true;
        }
      });
    });
  }

  getUserEstimate() {
    Estimate_Select_Data.getUserEstimate(user_id!).then((value) {
      print(value);
      setState(() {
        estimate = value;
        if (value.isEmpty) {
          _isLoading = false;
        } else {
          _isLoading = true;
        }
      });
    });
  }

  @override
  void initState() {
    isChattingRoom = true;

    FirebaseMessaging.onMessage.listen((message) {
      setState(() {
        _isLoading = false;
      });
      user_id == null ? getEstimate() : getUserEstimate();
      isPro = user_id == null ? "Pro" : "Cus";
    });
    user_id == null ? getEstimate() : getUserEstimate();
    isPro = user_id == null ? "Pro" : "Cus";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          '채팅',
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
      backgroundColor: Color(0xFFf0f0f0),
      body: _isLoading
          ? ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: estimate.length,
              itemBuilder: (BuildContext context, int index) {
                return ChatBox(
                    estimate: estimate[index], estimate2: estimate[index].estimate2, index: index, isPro: isPro);
              },
            )
          : const Center(
              child: Text('채팅이 없습니다'),
            ),
    );
  }
}

class ChatBox extends StatefulWidget {
  const ChatBox({
    Key? key,
    required this.index,
    required this.isPro,
    required this.estimate,
    required this.estimate2,
  }) : super(key: key);
  final int index;
  final String isPro;
  final String estimate2;
  final Select_Estimate estimate;

  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  String chat = "";

  @override
  void initState() {
    super.initState();
    chat = widget.estimate.chat == "" ? "사진을 보냈습니다" : widget.estimate.estimate2 != "" ? "견적서가 도착했습니다" : widget.estimate.chat;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        print(widget.estimate.chat);
        var result = await Get.toNamed(
            '/chat/true?ordeer_id=${widget.estimate.order_id}&&estimate_id=${widget.estimate.estimate_id}&&user_id=${widget.estimate.user_id}&&com_name=${widget.estimate.com_name}&&isPro=${widget.isPro}&&index=${widget.index}&&token=${widget.estimate.token}');
        print(result);
        print('aadwd ${widget.estimate.estimate2}');
        setState(() {
          chat = widget.estimate.chat == "" ? "사진을 보냈습니다" : widget.estimate.chat;
        });
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        width: Get.width,
        height: 100.0,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.isPro == "Cus"
                  ? widget.estimate.com_name
                  : widget.estimate.user_id,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Flexible(
              child: Text(
                chat,
                style: const TextStyle(color: Colors.black45),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                DateFormat("yyyy-MM-dd hh:mm").format(DateTime.parse(
                    widget.estimate.chat == " "
                        ? widget.estimate.estimate_date
                        : widget.estimate.createAt)),
                style: const TextStyle(fontSize: 12, color: Colors.black45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
