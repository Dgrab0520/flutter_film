import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_film/datas/banner_data.dart';
import 'package:flutter_film/models/banner_model.dart';
import 'package:get/get.dart';

class CarouselAd extends StatefulWidget{
  @override
  _CarouselAdState createState() => _CarouselAdState();
}

class _CarouselAdState extends State<CarouselAd>{

  List<Bbanner>? _banner;
  bool? _isLoading;
  // int _current = 0;
  // final CarouselController _controller = CarouselController();

  @override
  void initState(){
    super.initState();
    _isLoading = false;
    _banner = [];
    _getBanner();
  }

  _getBanner(){
    Banner_Data.getBanner().then((banner){
      setState(() {
        _banner = banner;
      });
      print(_banner);
      if(banner.length == 0){
        _isLoading = false;
      }else{
        _isLoading = true;
      }
    });
  }




  @override
  Widget build(BuildContext context){
    Widget imageSliders = new Container(
      height: 120.0,
      child: _isLoading! ?
      Column(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
                height: 80,
                autoPlay: false,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                // onPageChanged: (index, reason){
                //   setState(() {
                //     _current = index;
                //   });
                // }
            ),
            // carouselController: _controller,
            items: _banner?.map((item) {
              return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          child: Stack(
                            children: <Widget>[
                              GestureDetector(
                                child: Image.network(item.main_img, height: 80, width: Get.width, fit: BoxFit.fitWidth),
                                onTap: (){
                                  print('Ad No: ${item.banner_id} Selected');
                                },
                              ),
                            ],
                          ),
                        )
                    );
                  }
              );
            })?.toList() ?? [],
          ),
        ],
      ):Container(child: Text(''),),
    );
    return Container(
      child: Column(
        children: <Widget>[
          imageSliders,
        ],
      ),
    );
  }
}