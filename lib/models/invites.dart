import 'package:change_my_mind/models/person.dart';
import 'package:http/http.dart';

class Invites {
  String? takeInvite;
  String? sendInvite;
  String? inviteSituation;
  String? matchQuestion;

  Invites(
      {required this.takeInvite,
      required this.sendInvite,
      required this.inviteSituation,
      required this.matchQuestion});

  factory Invites.fromJson(Map<String, dynamic> json) => Invites(
      takeInvite: json["takeInvite"],
      sendInvite: json["sendInvite"],
      inviteSituation: json["inviteSituation"],
      matchQuestion: json["matchQuestion"]);

  Map<String, dynamic> toJson() => {
        "takeInvite": takeInvite,
        "sendInvite": sendInvite,
        "inviteSituation": inviteSituation,
        "matchQuestion" : matchQuestion
      };
}
