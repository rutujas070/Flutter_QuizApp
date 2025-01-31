import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp_withapi/view/firstscreen.dart';

/// SPLASH SCREEN CLASS THAT SERVES AS THE INTRODUCTORY SCREEN OF THE QUIZ APP
/// THIS SCREEN DISPLAYS A WELCOME MESSAGE AND NAVIGATES TO THE MAIN QUIZ PAGE AFTER A DELAY
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State createState() => _SplashscreenState();
}

class _SplashscreenState extends State {
  /// INITIAL STATE METHOD CALLED WHEN THE WIDGET IS FIRST CREATED
  @override
  void initState() {
    super.initState();
  }

  /// FUNCTION THAT NAVIGATES TO THE MAIN VIEWPAGE AFTER A SPECIFIED DELAY
  void navigate(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () async {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return Viewpage();
          },
        ),
      );
    });
  }

  /// BUILDS THE UI OF THE SPLASH SCREEN
  @override
  Widget build(BuildContext context) {
    navigate(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(154, 166, 178, 1),
      body: Center(
        child: Text(
          "LET'S SOLVE QUIZ",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 35,
            letterSpacing: 5.5,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}





