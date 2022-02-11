import 'package:flutter/material.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

bool _isPush = true;
bool _isEmail = true;
bool _isNews = true;

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          '마이페이지',
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
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFFf0f0f0),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20.0),
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  color: const Color(0xFFffffff),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        '앱푸시',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Switch(
                        value: _isPush,
                        onChanged: (value) {
                          setState(() {
                            _isPush = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20.0),
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  color: const Color(0xFFffffff),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        '이메일',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Switch(
                        value: _isEmail,
                        onChanged: (value) {
                          setState(() {
                            _isEmail = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20.0),
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  color: const Color(0xFFf0f0f0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            '소식 알리미',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '프로모션, 업데이트 등 소식을 받아보세요',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: _isNews,
                        onChanged: (value) {
                          setState(() {
                            _isNews = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
