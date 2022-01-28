import 'package:change_my_mind/views/first_page.dart';
import 'package:change_my_mind/views/login_page.dart';
import 'package:change_my_mind/views/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

SharedPreferences? sharedPreferences;
bool isLogin = false;

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Init.instance.initialize(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Splash(),
            );
          } else {
            return isLogin ? MainPage() : FirstPage();
          }
        });
  }

  void checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences?.getString("token"));
    if (sharedPreferences?.getString("token") == null) {
      isLogin = false;
    } else if (sharedPreferences?.getString("token") != null) {
      isLogin = true;
    }
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(height: 120,),
              Center(child: CircleAvatar(radius: 200,child: Image(image: AssetImage("assets/images/change.jpg"),width: 200,height: 200,),)),
              SizedBox(height: 20,),
              CircularProgressIndicator(),
              
            ],
          ),
          
          decoration: BoxDecoration(
              
              image: DecorationImage(
                  image: AssetImage("assets/images/1.jpg"), fit: BoxFit.cover)),
        ),
      ),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();
  Future initialize() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
