import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_film/datas/select_estimate_data.dart';
import 'package:flutter_film/main.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatListPage extends StatelessWidget {
  ChatListPage({Key? key}) : super(key: key);

  getEstimate() {
    userId == null
        ? estimateController.getProEstimate(proId!)
        : estimateController.getUserEstimate(userId!);
  }

  final String? proId = Get.parameters['pro_id'];
  final String? userId = Get.parameters['user_id'];

  final estimateController = Get.put(Estimate_Select_Data());
  @override
  Widget build(BuildContext context) {
    isChattingRoom = true;
    String isPro = userId == null ? "Pro" : "Cus";

    FirebaseMessaging.onMessage.listen((message) {
      getEstimate();
    });
    getEstimate();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
          title: const Text(
            '채팅',
            style: TextStyle(
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
            },
          ),
        ),
        backgroundColor: const Color(0xFFf0f0f0),
        body: Obx(
          () => estimateController.isLoading
              ? estimateController.estimate.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: estimateController.estimate.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ChatBox(index: index, isPro: isPro);
                      },
                    )
                  : const Center(
                      child: Text("진행중인 채팅이 없습니다"),
                    )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}

class ChatBox extends StatelessWidget {
  const ChatBox({
    Key? key,
    required this.index,
    required this.isPro,
  }) : super(key: key);
  final int index;
  final String isPro;

  @override
  Widget build(BuildContext context) {
    final estimateController = Get.put(Estimate_Select_Data());
    return InkWell(
      onTap: () {
        Get.toNamed(
            '/chat/true?estimate_id=${estimateController.estimate[index].estimate_id}&&user_id=${estimateController.estimate[index].user_id}&&com_name=${estimateController.estimate[index].com_name}&&isPro=$isPro&&index=$index&&token=${estimateController.estimate[index].token}');
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: Get.width,
        height: 100.0,
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isPro == "Cus"
                  ? estimateController.estimate[index].com_name
                  : estimateController.estimate[index].user_id,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Flexible(
              child: Obx(
                () => Text(
                  estimateController.estimate[index].chat == ""
                      ? "사진을 보냈습니다."
                      : estimateController.estimate[index].chat,
                  style: const TextStyle(color: Colors.black45),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Obx(
                () => Text(
                  DateFormat("yyyy-MM-dd hh:mm").format(DateTime.parse(
                      estimateController.estimate[index].chat == " "
                          ? estimateController.estimate[index].estimate_date
                          : estimateController.estimate[index].createAt)),
                  style: const TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
