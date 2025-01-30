
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp_withapi/View.dart';
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});
  @override
  State createState() => _SplashscreenState();
}

class _SplashscreenState extends State {
  @override
  void initState() {
    super.initState();
  }
  void navigate(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () async {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return const Viewpage();
            },
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
   navigate(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 106, 177, 207),
      body: Center(
        child:  Text(
                  "Let's Solve Quiz",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 35,
                    letterSpacing: 5.5,
                    color: Colors.white
                  ),
                ),
      ),
    );
  }
}
