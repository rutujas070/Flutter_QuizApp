import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp_withapi/view/firstscreen.dart';

/// SCORE SCREEN CLASS REPRESENTING THE END SCREEN OF THE QUIZ
/// THIS SCREEN DISPLAYS THE USER'S TOTAL SCORE AND ALLOWS THEM TO RESTART THE QUIZ

// ignore: must_be_immutable
class Scorescreen extends StatefulWidget {
  /// TOTAL SCORE OBTAINED BY THE USER
  int totalScore;
  
  /// TOTAL NUMBER OF QUESTIONS ATTEMPTED
  int questionCount;
  
  Scorescreen({super.key, required this.totalScore, required this.questionCount});

  @override
  State<Scorescreen> createState() => _ScorescreenState();
}

class _ScorescreenState extends State<Scorescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "QUIZ END",
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(154, 166, 178, 1),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          Row(
            children: [
              const SizedBox(
                width: 100,
              ),
              /// CONTAINER DISPLAYING A TROPHY IMAGE REPRESENTING SUCCESS
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(188, 204, 220, 1),
                  border: Border.all(
                    color: const Color.fromRGBO(154, 166, 178, 1),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(
                  "https://img.freepik.com/premium-photo/gold-champion-trophy-blue-background_564714-4193.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          /// CONGRATULATORY MESSAGE DISPLAYED ON SCREEN
          Text(
            "CONGRATULATIONS!",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 25,
              color: const Color.fromARGB(255, 218, 197, 76),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          /// DISPLAYS THE FINAL SCORE OF THE USER
          Text(
            "Score: ${widget.totalScore}/${widget.questionCount}",
            style: GoogleFonts.poppins(
              color: const Color.fromRGBO(154, 166, 178, 1),
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          /// BUTTON TO RESTART THE QUIZ
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                return Viewpage(
                  questionCount: widget.questionCount,
                );
              }));
              setState(() {});
            },
            style: ButtonStyle(
              side: WidgetStateProperty.all(
                const BorderSide(
                  color: Color.fromRGBO(154, 166, 178, 1),
                  width: 3.0,
                ),
              ),
              backgroundColor: const WidgetStatePropertyAll(
                Color.fromRGBO(188, 204, 220, 1),
              ),
            ),
            child: Text(
              "Restart",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
