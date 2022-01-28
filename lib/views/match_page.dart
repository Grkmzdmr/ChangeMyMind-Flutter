import 'package:change_my_mind/models/invites.dart';
import 'package:change_my_mind/views/chat_page.dart';
import 'package:change_my_mind/views/profil_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MatchPage extends StatefulWidget {
  const MatchPage({Key? key}) : super(key: key);

  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  late Future<List<Invites>> veri;
  String url =
      "https://raw.githubusercontent.com/Grkmzdmr/json_map/master/lib/assets/data/invites.json";
  Future<List<Invites>> getInvites() async {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => Invites.fromJson(e))
          .toList();
    } else {
      throw Exception("Bağlantı hatası");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    veri = getInvites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Eşleşme İstekleri"),
        ),
        body:  Container(
              child: FutureBuilder(
                
                builder: (context, AsyncSnapshot<List<Invites>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Container(
                              height: MediaQuery.of(context).size.height - 580,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Container(child: Text(snapshot.data![index].matchQuestion.toString(),style: TextStyle(fontSize: 21),),height: 50,),
                                  ),
                                  Row(
                                    children: [
                                      
                                         Padding(
                                          padding: const EdgeInsets.only(left: 12,bottom :0),
                                          child: Container(child: Text(snapshot.data![index].sendInvite.toString(),style: TextStyle(fontSize: 19,color: Colors.blue.withOpacity(0.7)),)),
                                          
                                        ),
                                      
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10,left: 180),
                                        child: Container(child: IconButton(onPressed: (){}, icon: Icon(Icons.check_outlined,size: 34,))),
                                      ),
                                      SizedBox(width: 10,),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Container(child: IconButton(onPressed: (){}, icon: Icon(Icons.clear_sharp,size: 34,))),
                                      )

                                    ],
                                  ),
                                  
                                ],
                              ),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black,
                                     Colors.blueAccent.shade400,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(24),
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
                future: getInvites()
              ),
            
        
        ));
  }
}
