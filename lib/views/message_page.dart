import 'package:change_my_mind/models/invites.dart';
import 'package:change_my_mind/models/matches.dart';
import 'package:change_my_mind/views/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late Future<List<Matches>> veri;
  String url =
      "https://raw.githubusercontent.com/Grkmzdmr/json_map/master/lib/assets/data/matches.json";

  Future<List<Matches>> getMatches() async {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => Matches.fromJson(e))
          .toList();
    } else {
      throw Exception("Bağlantı hatası");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    veri = getMatches();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Eşleşmeler"),
          ),
          body: Container(
            child: FutureBuilder(
                builder: (context, AsyncSnapshot<List<Matches>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatPage(snapshot.data![index].secondPersonId)));
                            },
                            child: Card(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height - 660,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                          width: 80,
                                          child: Text(
                                            snapshot.data![index].secondPersonId
                                                .toString(),
                                            style: TextStyle(fontSize: 18),
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 220),
                                      child: Container(
                                        child: Text(
                                          snapshot.data![index].matchResult
                                              .toString(),
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(4, 8)),
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black,
                                        Colors.blueAccent.shade400,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    color: Colors.deepPurple.shade600),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
                future: getMatches()),
          )),
    );
  }
}
