class Question {
  int? questionId;
  int? answerPersonId;
  String? questionText;
  String? isAnswer;
  List<String>? potentialAnswers;

  Question(
      {required this.potentialAnswers,
      required this.questionId,
      required this.isAnswer,
      required this.answerPersonId,
      required this.questionText});

  factory Question.fromJson(Map<String, dynamic> json) => Question(
      potentialAnswers: json["potentialAnswers"] == null
          ? null
          : new List<String>.from(json["potentialAnswers"].map((x) => x)),
      questionId: json["questionId"],
      answerPersonId: json["answerPersonId"],
      isAnswer: json["isAnswer"],
      questionText: json["questionText"]);

  Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "questionText": questionText,
        "answerPersonId": answerPersonId,
        "isAnswer" : isAnswer,
        "potentialAnswers": potentialAnswers
      };
}
