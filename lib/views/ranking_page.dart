import 'package:change_my_mind/models/person.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RankPage extends StatefulWidget {
  const RankPage({Key? key}) : super(key: key);

  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  late Future<List<Person?>> veri;
  String url =
      "https://raw.githubusercontent.com/Grkmzdmr/json_map/master/lib/assets/data/info.json";

  Future<List<Person>> getPersonScore() async {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => Person.fromJson(e))
          .toList();
    } else {
      throw Exception("Bağlantı hatası");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    veri = getPersonScore();
    if (veri != null) {
      veri.then((value) =>
          value.sort((a, b) => b!.personScore!.compareTo(a!.personScore as int)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Başarı Sıralaması"),
        ),
        body: Container(
          child: FutureBuilder(
            builder: (context, AsyncSnapshot<List<Person?>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shadowColor: Colors.black,
                       
                        child: Container(
                          height: MediaQuery.of(context).size.height - 660,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.emoji_events,
                                size: 34,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                
                                  width:
                                      MediaQuery.of(context).size.width - 320,
                                  child: Text(
                                    snapshot.data![index]!.sign.toString(),
                                    style: TextStyle(fontSize: 18),
                                  )),
                              SizedBox(
                                width: 180,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  
                                    child: Text(
                                  snapshot.data![index]!.personScore.toString(),
                                  style: TextStyle(fontSize: 20),
                                )),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(4, 8)
                       ),],

                             
                              gradient: LinearGradient(
                                
                                
                                colors: [
                                  Colors.black,
                                  Colors.blueAccent.shade400,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            
                              color: Colors.deepPurple.shade600),
                        ),
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            future: veri,
          ),
        ));
  }
}
