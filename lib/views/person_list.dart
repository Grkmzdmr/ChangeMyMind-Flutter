import 'package:change_my_mind/models/person.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PersonListPage extends StatefulWidget {
  const PersonListPage({Key? key}) : super(key: key);

  @override
  _PersonListPageState createState() => _PersonListPageState();
}

class _PersonListPageState extends State<PersonListPage> {
  String url =
      "https://raw.githubusercontent.com/Grkmzdmr/json_map/master/lib/assets/data/info.json";

  Future<List<Person>> getPerson() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print(response.body.toString());
      return (json.decode(response.body) as List)
          .map((e) => Person.fromJson(e))
          .toList();
    } else {
      throw Exception("Bağlantı Hatası ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,      
        home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(items: [BottomNavigationBarItem(icon: Icon(Icons.search),label: "Arama",),BottomNavigationBarItem(icon: Icon(Icons.add_comment),label: "Yorum Ekle")],),
        
        appBar: AppBar(title: Text("Kullanıcı Listesi"),
        leading: IconButton(icon: Icon(Icons.person),onPressed: (){},),
        actions: [
          ElevatedButton(onPressed: (){

          }, child: Icon(Icons.more_horiz))
        ],),
        body: Container(
          child: FutureBuilder(
              future: getPerson(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Person>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title:
                              Text(snapshot.data![index].sign.toString()),
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
