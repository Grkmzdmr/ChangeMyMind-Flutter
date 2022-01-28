import 'package:change_my_mind/views/main_page.dart';
import 'package:change_my_mind/views/message_page.dart';

import 'package:change_my_mind/views/profil_page.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  String? username;
  ChatPage(this.username);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.blue.withOpacity(1),
                  ),
                  color: Colors.blue.withOpacity(1),
                  iconSize: 24,
                ),
                SizedBox(
                  width: 2,
                ),
               /* GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilPage()));
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://randomuser.me/api/portraits/men/3.jpg"),
                    radius: 24,
                  ),
                ),*/
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.username!,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  icon: Icon(
                    Icons.check,
                    size: 28,
                    color: Colors.blue.withOpacity(1),
                  ),
                  tooltip: "İkna Oldum",
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 5, bottom: 10, top: 10),
              height: 70,
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Mesaj Yazın...",
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue.withOpacity(0.7)),
                            
                            borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 7, bottom: 2),
                    child: FloatingActionButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 22,
                      ),
                      backgroundColor: Colors.blue.withOpacity(1),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget sureButton = new TextButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith(
                (state) => Colors.blue.withOpacity(1))),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainPage()));
        },
        child: Text(
          "Evet",
          style: TextStyle(fontSize: 18),
        ));
    Widget notsureButton = new TextButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith(
                (state) => Colors.blue.withOpacity(1))),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "Hayır",
          style: TextStyle(fontSize: 18),
        ));

    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24.0))),
      title: Text(
        "İkna",
        style: TextStyle(fontSize: 22),
      ),
      content: Text(
        "İkna Oldunuz Mu ?",
        style: TextStyle(fontSize: 22),
      ),
      actions: [sureButton, notsureButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
