import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_film/pages/ad_page.dart';
import 'package:flutter_film/pages/agree_apge.dart';
import 'package:flutter_film/pages/changephone_page.dart';
import 'package:flutter_film/pages/changepw_page.dart';
import 'package:flutter_film/pages/chat_page.dart';
import 'package:flutter_film/pages/chatlist_page.dart';
import 'package:flutter_film/pages/customermy_page.dart';
import 'package:flutter_film/pages/deposit_page.dart';
import 'package:flutter_film/pages/login_page.dart';
import 'package:flutter_film/pages/main_page.dart';
import 'package:flutter_film/pages/matching_page.dart';
import 'package:flutter_film/pages/noti_page.dart';
import 'package:flutter_film/pages/notice_page.dart';
import 'package:flutter_film/pages/orderList_Customer_page.dart';
import 'package:flutter_film/pages/orderList_dir_page.dart';
import 'package:flutter_film/pages/orderList_page.dart';
import 'package:flutter_film/pages/order_page.dart';
import 'package:flutter_film/pages/point_page.dart';
import 'package:flutter_film/pages/profileP_edit_page.dart';
import 'package:flutter_film/pages/profileP_page.dart';
import 'package:flutter_film/pages/profile_page.dart';
import 'package:flutter_film/pages/promy_page.dart';
import 'package:flutter_film/pages/rating_page.dart';
import 'package:flutter_film/pages/registerProfile_page.dart';
import 'package:flutter_film/pages/register_page.dart';
import 'package:flutter_film/pages/request_page.dart';
import 'package:flutter_film/pages/review_page.dart';
import 'package:flutter_film/pages/search_page.dart';
import 'package:flutter_film/pages/search_pw_page.dart';
import 'package:flutter_film/pages/search_result_page.dart';
import 'package:flutter_film/pages/send_estimate_page.dart';
import 'package:flutter_film/pages/sms_page.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

bool isChattingRoom = false;

void main() async {
  KakaoContext.clientId = "9e7b120390d4b5e500c1979c182d62d5";
  KakaoContext.javascriptClientId = "28531eb53356ce1208b9358ecd53cc77";
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashPage(),
        getPages: [
          GetPage(name: '/main/:param', page: () => MainPage()),
          //MainPage
          GetPage(
            name: '/order/:param',
            page: () => OrderPage(),
          ),
          GetPage(
            name: '/profilePPage/:param',
            page: () => ProfilePPage(),
          ),
          GetPage(
            name: '/profilePEditPage/:param',
            page: () => ProfileP_EditPage(),
          ),
          GetPage(
            name: '/orderListPage',
            page: () => OrderListPage(),
          ),
          GetPage(
            name: '/pointPage/:param',
            page: () => PointPage(),
          ),
          GetPage(
            name: '/proMyPage/:param',
            page: () => ProMyPage(),
          ),
          GetPage(
            name: '/customerMyPage/:param',
            page: () => CustomerMyPage(),
          ),
          GetPage(
            name: '/loginPage',
            page: () => LoginPage(),
          ),
          GetPage(
            name: '/registerProfilePage/:param',
            page: () => RegisterProfilePage(),
          ),
          GetPage(
            name: '/profilePage/:param',
            page: () => ProfilePage(),
          ),
          GetPage(
            name: '/orderList/:param',
            page: () => OrderListPage(),
          ),
          GetPage(
            name: '/sendEstimate/:param',
            page: () => SendEstimate_Page(),
          ),
          GetPage(
            name: '/FilmChat/:param',
            page: () => ChatListPage(),
          ),
          GetPage(
            name: '/chatlist/:param',
            page: () => ChatListPage(),
          ),
          GetPage(
            name: '/chat/:param',
            page: () => ChatPage(),
          ),
          GetPage(
            name: '/deposit/:par`am',
            page: () => DepositPage(),
          ),
          GetPage(
            name: '/customerList/:param',
            page: () => CustomerOrderListPage(),
          ),
          GetPage(
            name: '/matching/:param',
            page: () => MatchingPage(),
          ),
          GetPage(
            name: '/rating/:param',
            page: () => RatingPage(),
          ),
          GetPage(
            name: '/review/:param',
            page: () => ReviewPage(),
          ),
          GetPage(
            name: '/request/:param',
            page: () => RequestPage(),
          ),
          GetPage(
            name: '/sms/:param',
            page: () => SmsPage(),
          ),
          GetPage(
            name: '/ad/:param',
            page: () => AdPage(),
          ),
          GetPage(
            name: '/notice/:param',
            page: () => NoticePage(),
          ),
          GetPage(
            name: '/agree/:param',
            page: () => AgreePage(),
          ),
          GetPage(
            name: '/changeph/:param',
            page: () => ChangePage(),
          ),
          GetPage(
            name: '/changepw/:param',
            page: () => ChangePW_Page(),
          ),
          GetPage(
            name: '/searchid/:param',
            page: () => SearchPage(),
          ),
          GetPage(
            name: '/searchpw/:param',
            page: () => SearchPWPage(),
          ),
          GetPage(
            name: '/noti/',
            page: () => NotiPage(),
          ),
          GetPage(
            name: '/searchResult/:param',
            page: () => SearchResultPage(),
          ),
          GetPage(
            name: '/dir_orderList/:param',
            page: () => Dir_OrderListPage(),
          ),
          GetPage(
            name: '/register/:param',
            page: () => RegisterPage(),
          ),
        ]);
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    initDynamicLinks();
    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
        String? title = message.notification!.title;
        String? body = message.notification!.body;
        if (title != "채팅") {
          Get.defaultDialog(
              title: title!,
              content: Text(body!),
              titleStyle: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold),
              middleTextStyle: const TextStyle(fontSize: 11.0));
        } else {
          if (!isChattingRoom) {
            Get.snackbar("채팅", "메세지가 도착했습니다",
                duration: const Duration(milliseconds: 1200));
          }
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("OPEN!!!!!");
      print(message);
    });

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;

      print(deepLink);
      print(deepLink?.path);

      if (deepLink != null) {
        Get.to(LoginPage());
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    print(deepLink);

    if (deepLink != null) {
      // do something
    }
  }
  //
  //
  // void _movePage({String? deepLinkPath}) async {
  //   if (deepLinkPath == null) {
  //     print('deepLinkPath : $deepLinkPath');
  //     //이건 스플래쉬 화면이 너무 빨리 넘어가서 앱을 다이나믹링크가 아닌 일반적으로 킬 때, sleep 으로 스플래시 화면이 더 오래 띄워지게 해놨당
  //     // sleep(const Duration(seconds: 2));
  //     // Get.offAll(() => MainPage());
  //   } else {
  //     print('deepLinkPath : $deepLinkPath');
  //     //여기서 routes 또는 getPages에서 설정한 path의 화면으로 넘어간다
  //     // Get.offAllNamed(deepLinkPath);
  //   }
  //   // if (user.registeredAt == null) {
  //   //   Get.offAll(() => Login());
  //   // } else {
  //   //   if (deepLinkPath == null) {
  //   //     //이건 스플래쉬 화면이 너무 빨리 넘어가서 앱을 다이나믹링크가 아닌 일반적으로 킬 때, sleep 으로 스플래시 화면이 더 오래 띄워지게 해놨당
  //   //     sleep(const Duration(seconds: 2));
  //   //     Get.offAll(() => MainPage());
  //   //   } else {
  //   //     //여기서 routes 또는 getPages에서 설정한 path의 화면으로 넘어간다
  //   //     Get.offAllNamed(deepLinkPath);
  //   //   }
  //   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SplashScreenView(
          navigateRoute: MainPage(),
          duration: 2000,
          imageSize: 70,
          imageSrc: 'assets/images/logo.gif',
          text: '인테리어 필름 시공전문',
          backgroundColor: Colors.white,
        ));
  }
}
