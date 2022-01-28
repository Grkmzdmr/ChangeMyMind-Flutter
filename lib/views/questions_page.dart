import 'dart:convert';

import 'package:change_my_mind/models/person.dart';
import 'package:change_my_mind/models/question.dart';
import 'package:change_my_mind/views/main_page.dart';
import 'package:change_my_mind/views/person_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QuestionsPage extends StatefulWidget {
  var result;
  QuestionsPage(this.result);

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  SharedPreferences? sharedPreferences;

  int number = 0;

  String url =
      "https://raw.githubusercontent.com/Grkmzdmr/json_map/master/lib/assets/data/question.json";

  Future<List<Question>> getQuestions() async {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => Question.fromJson(e))
          .toList();
    } else {
      throw Exception("Bağlantı hatası");
    }
  }

  @override
  Widget build(BuildContext context) {
    var userName = sharedPreferences?.getString("username");

    //bool? result = sharedPreferences?.getBool("isAnswered");
    

    return !widget.result
        ? Scaffold(
            appBar: AppBar(
              title: Text("Haftanın Soruları "),
            ),
            body: FutureBuilder(
              future: getQuestions(),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<Question>> snapshot,
              ) {
                if (snapshot.hasData) {
                  if (number == snapshot.data!.length) {
                    return Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          child: Text(
                            "Haftanın Sorularını Yanıtladınız Eşleşme Bekleyiniz...",
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue.withOpacity(0.7),
                            fixedSize: Size(160, 60),
                          ),
                          onPressed: () async {
                            sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences?.setBool("isAnswered", true);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage()));
                          },
                          child: Text(
                            "Ana Sayfaya Gidiniz...",
                            style: TextStyle(fontSize: 18),
                          ))
                    ]);
                  } else {
                    return Column(
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 150, left: 10),
                            width: 350,
                            height: 200,
                            child: Text(
                              snapshot.data![number].questionText.toString(),
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: snapshot.data![number].potentialAnswers !=
                                  null
                              ? snapshot.data![number].potentialAnswers!
                                  .map((weakness) => ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.blue.withOpacity(0.7),
                                        fixedSize: Size(160, 60),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          number++;
                                        });
                                      },
                                      child: Text(
                                        weakness,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )))
                                  .toList()
                              : [Text("Cevap yok")],
                        ),
                      ],
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        : Scaffold(
            body: Center(child: Container(
              width: MediaQuery.of(context).size.width - 50,
              child: Text("Bu haftaki soruları cevapladınız lütfen bir sonraki haftayı bekleyiniz...",style: TextStyle(fontSize: 18),),
            )),
          );
  }
}
