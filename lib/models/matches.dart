class Matches {
  String? firstPersonId;
  String? secondPersonId;
  bool? matchSituation;
  String? matchResult;
  String? matchQuestion;

  Matches(
      {required this.firstPersonId,
      required this.secondPersonId,
      required this.matchSituation,
      required this.matchResult,
      required this.matchQuestion});

  factory Matches.fromJson(Map<String, dynamic> json) => Matches(
      firstPersonId: json["firstPersonId"],
      secondPersonId: json["secondPersonId"],
      matchSituation: json["matchSituation"],
      matchResult: json["matchResult"],
      matchQuestion: json["matchQuestion"]);

  Map<String, dynamic> toJson() => {
        "firstPersonId": firstPersonId,
        "secondPersonId": secondPersonId,
        "matchSituation": matchSituation,
        "matchResult": matchResult,
        "matchQuestion" : matchQuestion
      };
}
