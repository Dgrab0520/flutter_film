import 'package:flutter/material.dart';
import 'package:flutter_film/datas/pro_select_data.dart';
import 'package:flutter_film/datas/rating_data.dart';
import 'package:flutter_film/models/pro_select_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  String? user_id;
  String? pro_id;
  double? _rating;
  TextEditingController reviewController = TextEditingController();
  bool? _isLoading;
  List<Pro_Select>? _profile;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _isLoading = false;
    _rating = 3.0;
    _profile = [];
    user_id = Get.parameters['user_id'];
    pro_id = Get.parameters['pro_id'];
    _getProSelect();
    super.initState();
  }

  _addRating() {
    RegisterRating_Data.addRating(
            pro_id!, user_id!, _rating.toString(), reviewController.text)
        .then((result) {
      if (result == 'success') {
      } else {
        Get.snackbar("Error", "네트워크 상태를 확인해주세요");
      }
    });
  }

  _getProSelect() {
    ProSelect_Data.getProSelect(pro_id!).then((profile) {
      setState(() {
        _profile = profile;
      });
      if (profile.length == 0) {
        _isLoading = false;
      } else {
        setState(() {
          _isLoading = true;
        });
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
        title: Text(
          '후기작성',
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
      backgroundColor: Color(0xFFF0F0F0),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 15.0,
            ),
            Container(
              height: Get.height * 0.3,
              width: Get.width,
              color: Colors.white,
              child: _isLoading!
                  ? Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              'http://211.110.1.58/film_pro_profile/${_profile![0].profile_img}',
                            ),
                            backgroundColor: Colors.white,
                            radius: 60,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            '${_profile![0].com_name}',
                            style: TextStyle(
                                fontSize: 23.0, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    )
                  : CircularProgressIndicator(),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: Get.width,
              height: Get.height * 0.40,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                  Spacer(),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    width: Get.width,
                    height: Get.height * 0.18,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 0.3, color: Colors.grey)),
                    child: TextField(
                      controller: reviewController,
                      maxLines: 8,
                      maxLength: 200,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              child: Text('    저장하기    '),
              onPressed: () {
                _addRating();
              },
            )
          ],
        ),
      ),
    );
  }
}
