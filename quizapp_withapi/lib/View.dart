
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'package:lottie/lottie.dart';
import 'package:quizapp_withapi/Scorescreen.dart';
import 'package:quizapp_withapi/controller/get_quizes.dart';
// import 'package:quizapp_withapi/controller/get_quizes.dart';
import 'package:quizapp_withapi/model/quizapp_model.dart';

class Viewpage extends StatefulWidget {
  const Viewpage({super.key});

  @override
  State<Viewpage> createState() => _ViewpageState();
}

class _ViewpageState extends State<Viewpage> {
  List<Quizapp> allQustion = [];

  int currentQuestionNumber = 0;
  int selectOptionIndex = -1;
  bool selected = false;
  int count = 0;
  bool isVisible = false;
  bool isCelebrat = false;


  ///LOGIC FOR CORRECT ANSWER
  WidgetStatePropertyAll<Color?> currentOpion(bool visitecOption) {
    if (selectOptionIndex != -1) {
      if (visitecOption) {
        return const WidgetStatePropertyAll(Colors.green);
      } else if (selected == visitecOption) {
        return const WidgetStatePropertyAll(Colors.red);
      } else {
        return const WidgetStatePropertyAll(null);
      }
    } else {
      return const WidgetStatePropertyAll(null);
    }
  }


  ///FUNCTION FOR GET DATA BY API
  // void getData() async {
  //   log("IN GET FUN");
  //   Uri url = Uri.parse("https://api.jsonserve.com/Uw5CrX");
  //   http.Response response = await http.get(url);

  //   /// Decode the response body
  //   dynamic jsonData = json.decode(response.body);

  //   // /// Check if the "questions" is null field exists
  //   // if (jsonData["questions"] == null) {
  //   //   log("Error: Missing 'questions' ");
  //   //   return;
  //   // }

  //   // Get the number of questions
  //   int jsonCount = jsonData["questions"].length;

  //   // Loop through each question in the questions array
  //   for (int i = 0; i < jsonCount; i++) {
  //     var question = jsonData["questions"][i];

  //     // Ensure that each question contains the necessary keys
  //     if (question != null &&
  //         question["description"] != null &&
  //         question["options"] != null) {
  //       // Add the extracted data to your allQustion list
  //       allQustion.add(Quizapp(
  //         question: question["description"], // Main question text
  //         options: [
  //           question["options"][0]["description"],
  //           question["options"][1]["description"],
  //           question["options"][2]["description"],
  //           question["options"][3]["description"]
  //         ], // Options descriptions
  //         description: question["detailed_solution"], // Detailed solution text
  //         iscorrect: [
  //           question["options"][0]["is_correct"],
  //           question["options"][1]["is_correct"],
  //           question["options"][2]["is_correct"],
  //           question["options"][3]["is_correct"]
  //         ], // Correctness of each option
  //       ));
  //     } else {
  //       log("Your API has null data index $i");
  //     }
  //   }
  //   log("$allQustion");
  //   setState(() {});
  // }


//FUNCTION FOR SCORE
  void score(bool counScore) {
    if (counScore) {
      count++;
      isCelebrat = !isCelebrat;
      setState(() {});
    }
  }


  @override
  void initState() {
    super.initState();
    // getData();
    Future.delayed(Duration(seconds: 1),()async{
    allQustion = await GetQuizes.getData();
    log("In Init=$allQustion");
setState(() {
  
});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: Text(
      "Quiz App",
      style: GoogleFonts.poppins(
          fontWeight: FontWeight.w700, fontSize: 35, color: Colors.black),
    ),
    centerTitle: true,
    backgroundColor: const Color.fromARGB(255, 106, 177, 207),
  ),
  body: LayoutBuilder(
    builder: (context, constraints) {
      double screenWidth = constraints.maxWidth;
      double screenHeight = constraints.maxHeight;
      
      return allQustion.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02,
                ),
                child:Stack(
                children: [
                 Column(
                  children: [
                    SizedBox(height: screenHeight * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Question: ${currentQuestionNumber + 1}/${allQustion.length}",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: screenWidth * 0.05, color: Colors.black),
                        ),
                        Text(
                          "Score: ${count}/${allQustion.length}",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: screenWidth * 0.05, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 198, 238, 254),
                        border: Border.all(
                          color: const Color.fromARGB(255, 106, 177, 207),
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SizedBox(
                        height: screenHeight * 0.3,
                        width: screenWidth * 0.9,
                        child: Text(
                          allQustion[currentQuestionNumber].question!,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: screenWidth * 0.05, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    ListView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder:(context,index){
                      return Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                        child: SizedBox(
                          height: screenHeight * 0.08,
                          width: screenWidth * 0.9,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (selectOptionIndex != 1) {
                                  selected = allQustion[currentQuestionNumber].iscorrect![index];
                                  selectOptionIndex = 0;
                                  score(allQustion[currentQuestionNumber].iscorrect![index]);
                                  currentOpion(allQustion[currentQuestionNumber].iscorrect![index]);
                                  isVisible = !isVisible;
                                }
                              });
                            },
                            style: ButtonStyle(
                              side: WidgetStateProperty.all(
                                const BorderSide(
                                    color: Color.fromARGB(255, 106, 177, 207),
                                    width: 3.0),
                              ),
                              backgroundColor: currentOpion(
                                  allQustion[currentQuestionNumber].iscorrect![index]),
                            ),
                            child: Text(
                              allQustion[currentQuestionNumber].options![index],
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: screenWidth * 0.045,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    }),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectOptionIndex != -1) {
                            if (currentQuestionNumber < allQustion.length - 1) {
                              currentQuestionNumber++;
                              selectOptionIndex = -1;
                              isVisible = false;
                              isCelebrat = false;
                            } else {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return Scorescreen(
                                    totalScore: count,
                                    questionCount: allQustion.length);
                              }));
                            }
                          }
                        });
                      },
                      child: Container(
                        height: screenHeight * 0.08,
                        width: screenWidth * 0.9,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 106, 177, 207),
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Text("Next",
                            style: GoogleFonts.poppins(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Visibility(
                      visible: isVisible,
                      child: Container(
                        width: screenWidth * 0.9,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 198, 238, 254),
                          border: Border.all(
                            color: const Color.fromARGB(255, 106, 177, 207),
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Explanation: ${allQustion[currentQuestionNumber].description}",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: screenWidth * 0.045,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: isCelebrat,
                  child: Container(
                    child: Lottie.asset("assets/Animation/Animation.json"),
                  ),
                )
                ],
                ),
              ),
            );
    },
  ),
);
  }
}
