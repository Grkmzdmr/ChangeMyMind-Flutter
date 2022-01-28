import 'dart:convert';
import 'dart:io';

import 'package:animated_button/animated_button.dart';
import 'package:change_my_mind/models/apiResponse.dart';
import 'package:change_my_mind/models/person.dart';
import 'package:change_my_mind/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_picker/flutter_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  

  int _value = 1;
  IconButton iconButton = new IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.male,
        size: 30,
      ));
  IconButton iconButton1 = new IconButton(
    onPressed: () {},
    icon: Icon(
      Icons.female,
      size: 30,
    ),
  );
  DateTime? pickedDate;
  bool _isUsernamefivecharacters = false;
  bool _hasPasswordeightcharacters = false;
  bool _hasPasswordonenumber = false;
  String? sign;
  String? password;
  bool hidePassword = true;
  bool? value = false;
  String label =
      "Gizlilik Politikası ve Kullanım Koşulları.Burada belirtilen gizlilik politikası ve kullanım koşulları; AKBARKOD'nin Google Play Store ve IOS App Store'da yayınlanan bütün mobil uygulamaları için geçerlidir. Bu uygulamaları mobil cihazınıza yükleyerek, bu metinde yer alan gizlilik politikasını ve kullanım koşullarını kabul etmiş sayılırsınız. Bu koşulları kabul etmiyorsanız bu uygulamaları mobil cihazınıza yüklemeyiniz.";

  Future<ApiResponse> registerUser(String sign, String password) async {
    ApiResponse _apiResponse = new ApiResponse();
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json-patch+json'
      };
      var uri = Uri.parse("http://92.44.187.131:5201/account/register");
      var payload = jsonEncode({"sign": sign, "password": password});
      var response = await http.post(uri, headers: headers, body: payload);

      switch (response.statusCode) {
        case 200:
          _apiResponse.Data =
              Person.fromJson(jsonDecode(response.body.toString()));
          if (response.body.contains("true")) {
            final snackBar = SnackBar(
              content: const Text(
                  "Başarıyla Kayıt Oldunuz.Giriş Ekranına yönlendiriliyorsunuz"),
              duration: Duration(seconds: 3, milliseconds: 30),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            await new Future.delayed(Duration(seconds: 4));
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          } else {
            final snackbar = SnackBar(
              content: const Text(
                  "Kayıt olurken sorun yaşadınız lütfen tekrar deneyiniz..."),
              duration: Duration(seconds: 3, milliseconds: 30),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
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
    // TODO: implement initState
    super.initState();
    pickedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height + 200,
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
                  Padding(
                    padding: const EdgeInsets.only(right: 340, top: 20),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        size: 28,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Kayıt olma ekranına hoş geldiniz.",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Yarışmaya başlamak için bilgilerini gir ve kayıt ol"),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onChanged: (input) {
                        setState(() {
                          if (input.length >= 5) {
                            _isUsernamefivecharacters = true;
                            sign = input;
                          } else {
                            _isUsernamefivecharacters = false;
                          }
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        hintText: "Kullanıcı Adı",
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.lightBlue, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 0),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: _isUsernamefivecharacters
                                ? Colors.green
                                : Colors.transparent,
                            border: _isUsernamefivecharacters
                                ? Border.all(color: Colors.transparent)
                                : Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Kullanıcı isminizin uzunluğu 5 haneden büyük olmalıdır.",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: TextFormField(
                        obscureText: hidePassword,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (input) {
                          final numericRegex = RegExp(r'[0-9]');
                          setState(() {
                            if (input.length >= 8) {
                              _hasPasswordeightcharacters = true;
                            } else {
                              _hasPasswordeightcharacters = false;
                            }
                            if (numericRegex.hasMatch(input)) {
                              _hasPasswordonenumber = true;
                            } else {
                              _hasPasswordonenumber = false;
                            }
                          });
                          password = input;
                        },
                        decoration: InputDecoration(
                          hintText: "Şifre",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.lightBlue, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.password_outlined),
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: _hasPasswordeightcharacters
                                ? Colors.green
                                : Colors.transparent,
                            border: _hasPasswordeightcharacters
                                ? Border.all(color: Colors.transparent)
                                : Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Şifrenizin uzunluğu 8 haneden büyük olmalıdır.",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: _hasPasswordonenumber
                                ? Colors.green
                                : Colors.transparent,
                            border: _hasPasswordonenumber
                                ? Border.all(color: Colors.transparent)
                                : Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Şifreniz en az 1 harf içermelidir.",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (input) {
                        //sign = textEditingController.text;
                      },
                      decoration: InputDecoration(
                        hintText: "Email Adresi",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.lightBlue, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: ListTile(
                        leading: Icon(Icons.date_range),
                        trailing: Icon(Icons.keyboard_arrow_down),
                        title: Text(
                          "Doğum Tarihi :      ${pickedDate!.day}/${pickedDate!.month}/${pickedDate!.year}",
                          style: TextStyle(fontSize: 18),
                        ),
                        onTap: _pickDate,
                      )),
                  Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: _value,
                            onChanged: (int? value) {
                              setState(() {
                                _value = value!;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Erkek"),
                          SizedBox(
                            width: 100,
                          ),
                          Radio(
                            value: 2,
                            groupValue: _value,
                            onChanged: (int? value) {
                              setState(() {
                                _value = value!;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Kadın"),
                        ],
                      )),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            value = !value!;
                          });
                        },
                        child: Checkbox(
                          value: value,
                          onChanged: (bool? newvalue) {
                            setState(() {
                              value = newvalue;
                            });
                          },
                          activeColor: Colors.white,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            AlertDialog alertDialog = AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24.0))),
                              title: Text(
                                "Gizlilik Politikamız",
                                style: TextStyle(fontSize: 22),
                              ),
                              content: Text(
                                label,
                                style: TextStyle(fontSize: 16),
                              ),
                              actions: [],
                            );
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alertDialog;
                                });
                          },
                          child: Text(
                              "Kullanım sözleşmelerini okudum ve kabul ediyorum.")),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AnimatedButton(
                      color: Colors.blue.withOpacity(0.7),
                      duration: 200,
                      height: 70,
                      width: 150,
                      shadowDegree: ShadowDegree.dark,
                      onPressed: () async {
                        if (_hasPasswordeightcharacters && _isUsernamefivecharacters) {
                          registerUser(sign!, password!);
                        } else {
                          SnackBar snackBar = SnackBar(
                            content: Text("Şifrenizi veya kullanıcı adınızı kontrol ediniz..."),
                            duration: Duration(seconds: 3, milliseconds: 30),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        
                      },
                      child: Text(
                        "Kayıt Ol",
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _pickDate() async {
    DateTime? date = await showDatePicker(
        locale: Locale("tr"),
        context: context,
        initialDate: DateTime(DateTime.now().year - 20),
        firstDate: DateTime(DateTime.now().year - 80),
        lastDate: DateTime(DateTime.now().year - 12));

    if (date != null) {
      setState(() {
        pickedDate = date;
      });
    } else {}
  }
}
