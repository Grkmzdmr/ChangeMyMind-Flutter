import 'package:change_my_mind/models/answer.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AnswerPage extends StatefulWidget {
  const AnswerPage({Key? key}) : super(key: key);

  @override
  _AnswerPageState createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  String url =
      "https://raw.githubusercontent.com/Grkmzdmr/json_map/master/lib/assets/data/answer.json";
  Future<List<Answer>> getAnswers() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => Answer.fromJson(e))
          .toList();
    } else {
      throw Exception("Baglantı Hatası:");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cevaplar"),
      ),
      body: FutureBuilder(
        future: getAnswers(),
        builder: (BuildContext context, AsyncSnapshot<List<Answer>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(itemCount: snapshot.data!.length,itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].questionId.toString()),
                subtitle: Text(snapshot.data![index].answerText as String),
              );
            });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
