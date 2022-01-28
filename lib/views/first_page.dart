import 'package:change_my_mind/views/login_page.dart';
import 'package:change_my_mind/views/second_page.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/1.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 10,
              ),
              FadeInUp(
                  duration: Duration(milliseconds: 1500),
                  child: Image.asset(
                    "assets/images/fp.png",
                    fit: BoxFit.fill,
                    height: 400,
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInUp(
                      delay: Duration(milliseconds: 1000),
                      duration: Duration(milliseconds: 1000),
                      child: Text(
                        "Hoşgeldin",
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    FadeInUp(
                      delay: Duration(milliseconds: 1200),
                      duration: Duration(milliseconds: 1000),
                      child: Text(
                        "Oyunun kurallarını ve oynanışını öğrenmek için ileriye tıkla.",
                        style: TextStyle(
                            fontSize: 17, height: 1.8, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              FadeInUp(
                delay: Duration(milliseconds: 1300),
                duration: Duration(milliseconds: 1000),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> SecondPage()));
                          },
                          color: Colors.blue.withOpacity(0.7),
                          height: 45,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding:
                              EdgeInsets.only(left: 25, right: 25, bottom: 4),
                          child: Center(
                            child: Text(
                              "İlerle",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            "GEÇ",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                height: 1.8,
                                color: Colors.white),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
