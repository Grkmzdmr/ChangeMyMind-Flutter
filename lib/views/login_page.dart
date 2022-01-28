import 'dart:convert';
import 'dart:io';

import 'package:change_my_mind/models/apiResponse.dart';
import 'package:change_my_mind/models/person.dart';
import 'package:change_my_mind/views/main_page.dart';
import 'package:change_my_mind/views/register_page.dart';
import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SharedPreferences? sharedPreferences;
  bool _isLoading = false;
  String? sign;
  String? password;
  bool hidePassword = true;
  TextEditingController textEditingController = TextEditingController();
  Future<ApiResponse> authenicateUser(String sign, String password) async {
    ApiResponse _apiResponse = new ApiResponse();
    try {
      Map<String, String> headers = {'Content-Type': 'application/json'};
      var uri = Uri.parse("http://92.44.187.131:5201/account/login");
      var payload = jsonEncode({"sign": sign, "password": password});
      var response = await http.post(uri, headers: headers, body: payload);
      var jsonresponse;
      sharedPreferences = await SharedPreferences.getInstance();

      switch (response.statusCode) {
        case 200:
          _apiResponse.Data =
              Person.fromJson(jsonDecode(response.body.toString()));

          print(response.body.toString());
          if (response.body.contains("true")) {
            jsonresponse = json.decode(response.body);
            print(jsonresponse["token"]);
            setState(() {
              _isLoading = false;
              sharedPreferences?.setString(
                  "token", jsonresponse["data"]["token"]);
              sharedPreferences?.setString(
                  "username", jsonresponse["data"]["sign"]);
              sharedPreferences?.setBool("isAnswered", false);
            });

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          } else {
            final snackBar = SnackBar(
              content:
                  const Text("Lütfen şifrenizi kontrol edin ve tekrar deneyin"),
              duration: Duration(seconds: 3, milliseconds: 30),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          break;
        case 401:
          break;
      }
    } on SocketException {
      print("Hata");
    }
    return _apiResponse;
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> setUserLogin(String auth_token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("auth_token", auth_token);
    pref.setBool("is_login", true);
  }

  Future<bool?> isUserLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("is_login");
  }

  Future<String?> isUserLogin1() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("auth_token");
  }

  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("auth_key");
    pref.remove("is_login");
  }

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.blueAccent.shade400,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          Text(
                            "Hoşgeldin",
                            style: TextStyle(fontSize: 30, fontFamily: "Lato"),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                              "Başlamak için lütfen kullanıcı bilgilerinizi doğru giriniz."),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: textEditingController,
                              onChanged: (input) {
                                sign = input;
                              },
                              decoration: InputDecoration(
                                hintText: "Kullanıcı Adı",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: TextFormField(
                                keyboardType: TextInputType.text,
                                obscureText: hidePassword,
                                onChanged: (input) {
                                  password = input;
                                },
                                validator: (input) => input!.length < 6
                                    ? "Şifrenizin uzunluğu 6'dan büyük olmalıdır."
                                    : null,
                                decoration: InputDecoration(
                                  hintText: "Şifre",
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  prefixIcon: Icon(
                                    Icons.password_rounded,
                                    color: Colors.white,
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          hidePassword = !hidePassword;
                                        });
                                      },
                                      icon: Icon(hidePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility)),
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            child: Text(
                              "Kayıt Ol",
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          AnimatedButton(
                            color: Colors.blue.withOpacity(0.7),
                            duration: 200,
                            height: 90,
                            width: 160,
                            shadowDegree: ShadowDegree.dark,
                            onPressed: () {
                              setState(() {
                                _isLoading = true;
                              });
                              if (sign != null && password != null) {
                                authenicateUser(sign!, password!);
                              } else if (sign == null || password == null) {
                                SnackBar snackBar = SnackBar(
                                  content: Text(
                                      "Şifrenizi ve kullanıcı adınızı boş bırakmayınız..."),
                                  duration:
                                      Duration(seconds: 3, milliseconds: 30),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Text(
                              "Giriş Yap",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
