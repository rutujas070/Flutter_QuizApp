import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:quizapp_withapi/view/scorescreen.dart';
import 'package:quizapp_withapi/controller/get_quizes.dart';
import 'package:quizapp_withapi/model/quizapp_model.dart';

/// VIEWPAGE CLASS - STATEFUL WIDGET FOR DISPLAYING QUIZ QUESTIONS
// ignore: must_be_immutable
class Viewpage extends StatefulWidget {
  /// VARIABLE TO DISPLAY QUESTION COUNT WHEN WE NAVIGATE HERE FROM SCORESCREEN.
  int? questionCount;
  Viewpage({super.key, this.questionCount});

  @override
  State<Viewpage> createState() => _ViewpageState();
}

class _ViewpageState extends State<Viewpage> {
  /// LIST TO STORE ALL QUIZ QUESTIONS
  List<Quizapp> allQustion = [];

  /// TRACK CURRENT QUESTION NUMBER
  int currentQuestionNumber = 0;

  /// TRACK SELECTED OPTION INDEX
  int selectOptionIndex = -1;

  /// STORE USER SCORE COUNT
  int count = 0;

  /// BOOLEAN TO CONTROL VISIBILITY OF EXPLANATION TEXT
  bool isVisible = false;

  /// BOOLEAN TO CONTROL CELEBRATION ANIMATION
  bool isCelebrat = false;

  /// FUNCTION TO RETURN COLOR FOR SELECTED OPTION BASED ON CORRECTNESS
  WidgetStatePropertyAll<Color?> currentOpion(int visitedOption) {
    /// CONDITION TURE IF ANY ONE OF BUTTON SELETED
    if (selectOptionIndex != -1) {
      if (visitedOption == allQustion[currentQuestionNumber].correctOption) {
        /// CONDITION TRUE IF THE ANSWER IS CORRECT TO APPLY BACGROUND COLOR OF BUTTON AS GREEN
        return const WidgetStatePropertyAll(Colors.green);
      } else if (selectOptionIndex == visitedOption) {
        /// CONDITION TRUE IF THE ANSWER IS WRONG TO APPLY BACGROUND COLOR OF BUTTON AS RED
        return const WidgetStatePropertyAll(Colors.red);
      } else {
        /// ALL REST BUTTON AS REMAIN UNCOLOR
        return const WidgetStatePropertyAll(null);
      }
    } else {
      /// IF USER DIDN'T SELECT ANY OPTION INITIAL COLOR IS NULL OR NO COLOR
      return const WidgetStatePropertyAll(null);
    }
  }

  /// FUNCTION TO UPDATE SCORE IF ANSWER IS CORRECT
  void score(int countScore) {
    if (countScore == allQustion[currentQuestionNumber].correctOption) {
      count++;
      /// ENABLE THE CELEBRATION ANIMATION
      isCelebrat = !isCelebrat;
      setState(() {});
    }
  }

  /// INIT STATE FUNCTION TO FETCH QUESTIONS FROM API
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () async {
      /// GETDATA FUNTION IS IN CONTOLLER IN GET_QUIZES.DART
      allQustion = await GetQuizes.getData();
      log("IN INIT = $allQustion");
      setState(() {});
    });
  }

  /// WIDGET BUILD FUNCTION - UI STRUCTURE FOR QUIZ SCREEN
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "QUIZ APP",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700, fontSize: 35, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(154, 166, 178, 1),
      ),

      /// LAYOUTBUILDER FOR RESPONSIVE APPLICATION ACCORDING TO DICTOP, MOBILE AND TAB
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          return allQustion.isEmpty
              ? const Center(child: CircularProgressIndicator())

              /// FOR LOADER RING UNTILL DATA FETCH FROM API
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.02,
                    ),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: screenHeight * 0.03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  /// DISPLAY QUESTION NUMBER AS CURRENTQUESTIONNUMBER
                                  /// DISPLAY WIDGET.QUESTIONCOUNT AS 10 WHEN WE NAVIGATE FORM SCORESCREEN TO RESTART QUIZ BECAUSE WHEN WE NAVIGATE HERE SO DATA GET ADD AGAIN IN THE ALLQUESTION LIST SO LENGTH BECOME 20.
                                  /// DISPLAY INITIALY ALLQUESTION.LENGTH
                                  "Question: ${currentQuestionNumber + 1}/${widget.questionCount == 10 ? widget.questionCount : allQustion.length}",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: screenWidth * 0.05,
                                      color: Colors.black),
                                ),
                                Text(
                                  /// DISPLAY SCORE HERE WITHC COUNTED IN score() FUNTION
                                  "Score: $count/${widget.questionCount == 10 ? widget.questionCount : allQustion.length}",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: screenWidth * 0.05,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.03),

                            /// DISPLAY CURRENT QUESTION
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(188, 204, 220, 1),
                                border: Border.all(
                                  color: const Color.fromRGBO(154, 166, 178, 1),
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
                                      fontWeight: FontWeight.w500,
                                      fontSize: screenWidth * 0.05,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),

                            /// FIRST OPTION BUTTON
                            SizedBox(
                              height: screenHeight * 0.08,
                              width: screenHeight * 0.9,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (selectOptionIndex == -1) {
                                    /// PASS THEN SELECTED OPTION NUMBR TO THE SELECTOPTIONINDEX TO APPLY RED COLOR IF OPTION IS WRONG
                                    selectOptionIndex = 0;

                                    /// PASS THE SELECTED OPTION NUMBR TO THE SCORE FUNTION TO INCRESE SCORE AND DISPLAY ANIMATION
                                    score(0);

                                    setState(() {
                                      /// ENABLE THE EXPLANATION CONTAINER VISIBLE 
                                      isVisible = !isVisible;
                                    });
                                  }
                                },
                                style: ButtonStyle(
                                  side: WidgetStateProperty.all(
                                    const BorderSide(
                                        color:Color.fromRGBO(154, 166, 178, 1),
                                        width: 3.0), 
                                  ),
                                  backgroundColor: currentOpion(0),
                                ),
                                child: Text(
                                  allQustion[currentQuestionNumber].options![0],
                                  style:TextStyle(
                                    fontSize:screenWidth * 0.05,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                             SizedBox(height: screenHeight * 0.03),

                             /// FIRST OPTION BUTTON
                            SizedBox(
                              height: screenHeight * 0.08,
                              width: screenHeight * 0.9,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (selectOptionIndex == -1) {
                                    selectOptionIndex = 1;
                                     score(1);
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  }
                                },
                                style: ButtonStyle(
                                  side: WidgetStateProperty.all(
                                    const BorderSide(
                                        color:Color.fromRGBO(154, 166, 178, 1),
                                        width: 3.0), 
                                  ),
                                  backgroundColor: currentOpion(1),
                                ),
                                child: Text(
                                  allQustion[currentQuestionNumber].options![1],
                                  style:TextStyle(
                                    fontSize:screenWidth * 0.05,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                             
                             /// THIRD  OPTION BUTTON
                            SizedBox(
                             height: screenHeight * 0.08,
                              width: screenHeight * 0.9,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (selectOptionIndex == -1) {
                                    selectOptionIndex = 2;
                                     score(2);
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  }
                                },
                                style: ButtonStyle(
                                  side: WidgetStateProperty.all(
                                    const BorderSide(
                                        color:Color.fromRGBO(154, 166, 178, 1),
                                        width: 3.0), 
                                  ),
                                  backgroundColor: currentOpion(2),
                                ),
                                child: Text(
                                  allQustion[currentQuestionNumber].options![2],
                                  style:TextStyle(
                                    fontSize:screenWidth * 0.05,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                             SizedBox(height: screenHeight * 0.03),
                             
                             /// FOURTH OPTION BUTTON
                            SizedBox(
                              height: screenHeight * 0.08,
                              width: screenHeight * 0.9,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (selectOptionIndex == -1) {
                                    selectOptionIndex = 3;
                                     score(3);
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  }
                                },
                                style: ButtonStyle(
                                  side: WidgetStateProperty.all(
                                    const BorderSide(
                                        color:Color.fromRGBO(154, 166, 178, 1),
                                        width: 3.0), 
                                  ),
                                  backgroundColor: currentOpion(3),
                                ),
                                child: Text(
                                  allQustion[currentQuestionNumber].options![3],
                                  style: TextStyle(
                                    fontSize:screenWidth * 0.05,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),

                            /// NEXT BUTTON FOR NEXT QUESTION
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectOptionIndex != -1) {
                                    /// IF CURRENTQUESTIONNUMBER IS LESS THAN THE ALLQUESTION.LENGTH-1 THEN ONLY NEXT QUESTION COME OTHERWISE QUESTION IS END.
                                    if (currentQuestionNumber <
                                        allQustion.length - 1) {
                                      /// INCREMENT CURRENTQUESTIONNUMBER AND INITIALISE ALL VARIABLE TO ORIGINAL VALUE
                                      currentQuestionNumber++;
                                      selectOptionIndex = -1;
                                      isVisible = false;
                                      isCelebrat = false;
                                    } else {
                                      /// IF QUESTION IS END THEN NAVIGATE TO SCORESCREEN
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
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.9,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(154, 166, 178, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Text("Next",
                                    style: GoogleFonts.poppins(
                                        fontSize:screenWidth * 0.05,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black)),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),

                            /// CONTAINER WITCH VISIBLE IF ANY ONE OF OPTION IS SELECTED TO DISPLAY EXPLANATION.
                            Visibility(
                              visible: isVisible,
                              child: Container(
                                width: screenWidth * 0.9,
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  // color: const Color.fromRGBO(218, 210, 255,1),
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(154, 166, 178, 1),
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

                        /// CONTAINER OR ANIMATION WITCH VISIBLE IF SELECTED OPTION IS CORRECT.
                        Visibility(
                          visible: isCelebrat,
                          child: Container(
                            child:
                                Lottie.asset("assets/Animation/Animation.json"),
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

