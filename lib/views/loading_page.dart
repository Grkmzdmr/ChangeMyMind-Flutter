import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({ Key? key }) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/1.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(child: CircularProgressIndicator(
        
      ),),
      
    );
  }
}