import 'package:change_my_mind/models/person.dart';

class Answer {
  int? questionId;
  List<Person>? answer1;
  List<Person>? answer2;
  int? personId;
  String? answerText;
  int? didAnswer;

  Answer(
      {required this.questionId,
      required this.personId,
      required this.answerText,
      required this.didAnswer});

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
      questionId: json["questionId"],
      personId: json["personId"],
      answerText: json["answerText"],
      didAnswer: json["didAnswer"]);
  Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "personId": personId,
        "answerText": answerText,
        "didAnswer": didAnswer
      };
}
