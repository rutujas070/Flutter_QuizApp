/// MODEL CLASS REPRESENTING A SINGLE QUIZ QUESTION WITH MULTIPLE OPTIONS IN QUIZ LIST WITCH IS ALLQUESTION LIST
class Quizapp {
  /// THE QUESTION TEXT
  String? question;

  /// LIST OF POSSIBLE OPTIONS FOR THE QUESTION
  List? options;

  /// EXPLANATION OR DESCRIPTION OF THE CORRECT ANSWER
  String? description;

  /// LIST INDICATING WHETHER EACH OPTION IS CORRECT (TRUE) OR INCORRECT (FALSE)
  List<bool>? iscorrect;

  /// INDEX REPRESENTING THE CORRECT OPTION IN THE OPTIONS LIST
  int? correctOption;

  /// CONSTRUCTOR FOR INITIALIZING THE QUIZ QUESTION MODEL
  Quizapp({

    /// ALL (NAMED)PARAMERS ARE REQUIRED TO PASS IN CONSTRUCTOR  SEQUENCE CAN CHANGE
    required this.question,
    required this.options,
    required this.description,
    required this.iscorrect,
    required this.correctOption,
  });
}





