import 'package:flutter/material.dart';
import 'package:flutter_film/datas/select_rating_data.dart';
import 'package:flutter_film/models/select_rating_model.dart';
import 'package:get/get.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  String? user_id;
  List<Select_Rating>? _ratingSelect;
  bool? _isLoading;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    user_id = Get.parameters['id'];
    _ratingSelect = [];
    _getRating();
    super.initState();
  }

  _getRating() {
    SelectRating_Data.getRating(user_id!).then((ratingSelect) {
      setState(() {
        _ratingSelect = ratingSelect;
      });
      if (ratingSelect.length == 0) {
        _isLoading = false;
      } else {
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
        title: Text(
          '리뷰',
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
      body: SafeArea(
        child: Container(
          height: Get.height * 0.8,
          width: Get.width,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _ratingSelect!.length,
              itemBuilder: (BuildContext context, int index) {
                return LazyLoadingList(
                  initialSizeOfItems: 10,
                  index: index,
                  hasMore: true,
                  loadMore: () => print('Loading More'),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: Get.width,
                          height: 0.3,
                          child: Container(
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '${_ratingSelect![index].user_id.substring(0, 3)}****',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.0),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFFFEC107),
                                      size: 13.0,
                                    ),
                                    SizedBox(
                                      width: 2.0,
                                    ),
                                    Text(
                                      '${_ratingSelect![index].rating}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13.0),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '${_ratingSelect![index].review}',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13.0),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
