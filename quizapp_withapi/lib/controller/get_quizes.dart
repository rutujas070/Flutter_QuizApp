import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart'as http;
import 'package:quizapp_withapi/model/quizapp_model.dart';

class GetQuizes{
 static List<Quizapp> allQustion = [];

  static Future<List<Quizapp>> getData() async {
    log("IN GET FUN");
    Uri url = Uri.parse("https://api.jsonserve.com/Uw5CrX");
    http.Response response = await http.get(url);

    /// Decode the response body
    dynamic jsonData = json.decode(response.body);

    // /// Check if the "questions" is null field exists
    // if (jsonData["questions"] == null) {
    //   log("Error: Missing 'questions' ");
    //   return;
    // }

    // Get the number of questions
    int jsonCount = jsonData["questions"].length;
    log("${jsonData["questions"].length}");


    // Loop through each question in the questions array
    for (int i = 0; i < jsonCount; i++) {
      var question = jsonData["questions"][i];

      // Ensure that each question contains the necessary keys
      if (question != null &&
          question["description"] != null &&
          question["options"] != null) {
        // Add the extracted data to your allQustion list
        allQustion.add(Quizapp(
          question: question["description"], // Main question text
          options: [
            question["options"][0]["description"],
            question["options"][1]["description"],
            question["options"][2]["description"],
            question["options"][3]["description"]
          ], // Options descriptions
          description: question["detailed_solution"], // Detailed solution text
          iscorrect: [
            question["options"][0]["is_correct"],
            question["options"][1]["is_correct"],
            question["options"][2]["is_correct"],
            question["options"][3]["is_correct"]
          ], // Correctness of each option
        ));
      } else {
        log("Your API has null data index $i");
      }
    }

    log("$allQustion");
    return allQustion;
    // setState(() {});
  }
}