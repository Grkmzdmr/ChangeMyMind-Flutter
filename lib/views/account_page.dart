import 'package:animated_button/animated_button.dart';
import 'package:change_my_mind/views/edit_account_page.dart';
import 'package:change_my_mind/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:day_night_switcher/day_night_switcher.dart';

class AccountPage extends StatefulWidget {
  String? username;
  String? avatarname;
  AccountPage(this.avatarname, this.username);
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hesabım"),
        actions: [],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("${widget.username}",style: TextStyle(fontSize: 33,fontWeight: FontWeight.bold,color: Colors.blue.shade800),),
              radius: 64,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "@${widget.avatarname}",
              style: TextStyle(fontSize: 26,fontWeight: FontWeight.w500,color: Colors.blue.shade700),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 150,
            ),
            AnimatedButton(
              color: Colors.blue.withOpacity(0.7),
              width: 160,
              height: 60,
              onPressed: () async {
                SharedPreferences? sharedPreferences;
                sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.clear();
                sharedPreferences.remove("token");

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()),
                    (route) => false);
              },
              child: Text(
                "Çıkış Yap",
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
