import 'package:change_my_mind/views/account_page.dart';
import 'package:change_my_mind/views/match_page.dart';
import 'package:change_my_mind/views/message_page.dart';

import 'package:change_my_mind/views/questions_page.dart';
import 'package:change_my_mind/views/ranking_page.dart';
import 'package:change_my_mind/views/splash_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SharedPreferences? sharedPreferences;

  late List<Widget> tumSayfalar;
  late MainPageWidget sayfaAna;
  int secilenMenuitem = 0;
  late MessagePage sayfaMesaj;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sayfaAna = MainPageWidget();
    sayfaMesaj = MessagePage();
    tumSayfalar = [sayfaAna, sayfaMesaj];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: BottomNav(),
        body: tumSayfalar[secilenMenuitem],
      ),
    );
  }

  BottomNavigationBar BottomNav() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.white,
            size: 26,
          ),
          label: "Ana Sayfa",
          backgroundColor: Colors.blue.withOpacity(0.7),
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              color: Colors.white,
              size: 26,
            ),
            label: "Eşleşmelerim",
            backgroundColor: Colors.blue.withOpacity(0.7)),
      ],
      currentIndex: secilenMenuitem,
      selectedItemColor: Colors.blue.withOpacity(0.7),
      onTap: (index) {
        setState(() {
          secilenMenuitem = index;
        });
      },
      type: BottomNavigationBarType.fixed,
    );
  }
}

class MainPageWidget extends StatelessWidget {
  const MainPageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userName = sharedPreferences?.getString("username");
    var result = sharedPreferences?.getBool("isAnswered");
    List<String> list = [];
    list.add(userName![0].toUpperCase());

    var avatarname = list[0];

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.width - 300,
              width: MediaQuery.of(context).size.width - 10,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(4, 8)),
                  ],
                  gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      Colors.blueAccent.shade400,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.shade800),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AccountPage(userName, avatarname)));
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        "$avatarname",
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.blue.shade800,
                            fontWeight: FontWeight.bold),
                      ),
                      radius: 32,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Hoşgeldin $userName ! ",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Noto",
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Başlamak için lütfen haftanın sorularını cevapla",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontFamily: "Lato"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              print(MediaQuery.of(context).size.width - 280);
              print(MediaQuery.of(context).size.height - 20);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => RankPage()));
            },
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width - 200,
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(4, 8)),
                      ],
                      gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.blueAccent.shade400,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, top: 65),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 85, left: 70),
                      child: Text(
                        "BAŞARI SIRALAMASI",
                        style: TextStyle(fontSize: 20, fontFamily: "Noto"),
                      ),
                    ),
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.width - 280,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(4, 8)),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      color: Colors.grey.shade800,
                      image: new DecorationImage(
                          image: new AssetImage("assets/images/sketch.jpg"),
                          fit: BoxFit.fill),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QuestionsPage(result)));
            },
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width - 200,
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(4, 8)),
                      ],
                      gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.blueAccent.shade400,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, top: 65),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 85, left: 70),
                      child: Text(
                        "HAFTANIN SORULARI",
                        style: TextStyle(fontSize: 20, fontFamily: "Noto"),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.width - 280,
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    color: Colors.grey.shade800,
                    image: DecorationImage(
                        image: new AssetImage("assets/images/q.jpg"),
                        fit: BoxFit.fill),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MatchPage()));
            },
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width - 200,
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(4, 8)),
                      ],
                      gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.blueAccent.shade400,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, top: 65),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 85, left: 70),
                      child: Text(
                        "EŞLEŞME İSTEKLERİ",
                        style: TextStyle(fontSize: 20, fontFamily: "Noto"),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.width - 280,
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    color: Colors.grey.shade800,
                    image: new DecorationImage(
                        image: new AssetImage("assets/images/m1.jpg")),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
