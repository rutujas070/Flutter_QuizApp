import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:quizapp_withapi/model/quizapp_model.dart';

/// CLASS RESPONSIBLE FOR FETCHING QUIZ DATA FROM AN API
class GetQuizes {
  /// LIST TO STORE ALL QUIZ QUESTIONS RETRIEVED FROM THE API
  static List<Quizapp> allQustion = [];

  /// PREDEFINED LIST OF CORRECT ANSWER INDICES FOR EACH QUESTION
  static List<int> correctAns = [2, 0, 0, 2, 3, 3, 2, 1, 3, 2];

  /// ASYNCHRONOUS FUNCTION TO FETCH QUIZ DATA FROM THE API
  /// 
  /// RETURNS A LIST OF `Quizapp` OBJECTS CONTAINING QUESTIONS, OPTIONS, AND CORRECT ANSWERS
  static Future<List<Quizapp>> getData() async {
    log("IN GET FUN");
    
    // DEFINE THE API URL
    Uri url = Uri.parse("https://api.jsonserve.com/Uw5CrX");
    
    // PERFORM AN HTTP GET REQUEST
    http.Response response = await http.get(url);
    
    // DECODE THE JSON RESPONSE
    dynamic jsonData = json.decode(response.body);
    int jsonCount = jsonData["questions"].length;
    log("TOTAL QUESTIONS: ${jsonData["questions"].length}");

    // ITERATE THROUGH THE JSON DATA TO EXTRACT QUESTIONS AND OPTIONS
    for (int i = 0; i < jsonCount; i++) {
      var question = jsonData["questions"][i];
      
      if (question != null &&
          question["description"] != null &&
          question["options"] != null) {
        
        // ADD QUESTION TO THE LIST
        allQustion.add(Quizapp(
          question: question["description"],
          options: [
            question["options"][0]["description"],
            question["options"][1]["description"],
            question["options"][2]["description"],
            question["options"][3]["description"]
          ],
        
        // ADD DISCRIPTION TO THE LIST
          description: question["detailed_solution"],

        // ADD CORRECT OPTION STATUS TO THE LIST
          iscorrect: [
            question["options"][0]["is_correct"],
            question["options"][1]["is_correct"],
            question["options"][2]["is_correct"],
            question["options"][3]["is_correct"]
          ],

        // ADD ONLY NUMBER OF CORRECT OPTION TO THE LIST
          correctOption: correctAns[i],
        ));
      } else {
        log("API RESPONSE CONTAINS NULL DATA AT INDEX $i");
      }
    }

    log("QUIZ QUESTIONS FETCHED SUCCESSFULLY: $allQustion");
    return allQustion;
  }
}
