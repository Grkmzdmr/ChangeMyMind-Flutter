
import 'package:change_my_mind/views/main_page.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil "),
        actions: [
          IconButton(
              onPressed: () {
                showAlertDialog(context);
              },
              icon: Icon(Icons.report))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/men/3.jpg"),
                radius: 56,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Görkem Özdemir",
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "@Grkmzdmr",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Doğa ve hayvan sever , 21 yaşında",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Scaffold(
            body: Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 10,
                height: MediaQuery.of(context).size.height - 80,
                padding: EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 350),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 36,
                          ),
                        )),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Lütfen şikayet etmek istediğiniz kullanıcıyı ve şikayet nedenini aşağıda ki kutucuğa yazınız.",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                        maxLength: 120,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            hintText: "Şikayetiniz buraya giriniz...",
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ))),
                    SizedBox(
                      height: 50,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Şikayet Et",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
