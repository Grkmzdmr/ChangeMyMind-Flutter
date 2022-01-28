import 'dart:convert';

import 'package:http/http.dart';

Person personFromJson(String str) => Person.fromJson(jsonDecode(str));
String personToJson(Person data) => json.encode(data.toJson());

class Person {
  int? personId;
  String? personEmail;
  String? personPassword;
  String? profilUrl;
  String? sign;
  String? personName;
  String? personSurname;
  int? personScore;
  String? isAnswered;

  Person(
      {required this.personEmail,
      required this.personId,
      required this.personName,
      required this.personPassword,
      required this.personSurname,
      required this.profilUrl,
      required this.sign,
      required this.personScore});

  factory Person.fromJson(Map<String, dynamic> json) => Person(
      personEmail: json["personEmail"],
      personId: json["personId"],
      personName: json["personName"],
      personPassword: json["personPassword"],
      personSurname: json["personSurname"],
      profilUrl: json["profilUrl"],
      sign: json["sign"],
      personScore: json["personScore"]);

  Map<String, dynamic> toJson() => {
        "personEmail": personEmail,
        "personId": personId,
        "personName": personName,
        "personPassword": personPassword,
        "personSurname": personSurname,
        "profilUrl ": profilUrl,
        "sign": sign,
        "personScore": personScore,
      };
}
