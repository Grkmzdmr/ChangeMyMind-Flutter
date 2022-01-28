import 'package:flutter/material.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({ Key? key }) : super(key: key);

  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profili Düzenle"),),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    
                    labelText: "İsim Soyisim",
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText : "Hakkımda"
                  ),
                ),
              ),
              SizedBox(height: 30,),
              TextButton(onPressed: (){}, child: Text("Kaydet",style: TextStyle(color: Colors.deepOrange),))
            ],
          ),
        ) ,),
      
    );
  }
}