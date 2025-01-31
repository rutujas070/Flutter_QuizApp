import 'package:flutter/material.dart';
import 'package:quizapp_withapi/view/splashcreen.dart';

/// MAIN FUNCTION - ENTRY POINT OF THE APPLICATION
void main() {
  /// INITIALIZES AND RUNS THE FLUTTER APPLICATION
  runApp(const MainApp()); 
}

/// MAIN APPLICATION WIDGET THAT SETS UP THE ROOT OF WIDGET TREE 
class MainApp extends StatelessWidget {
  /// CONSTRUCTOR FOR MAIN APPLICATION WIDGET
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      /// DISABLES DEBUG BANNER ON THE TOP-RIGHT CORNER
      debugShowCheckedModeBanner: false,

      /// SETS THE INITIAL SCREEN OF THE APPLICATION TO THE SPLASH SCREEN
      home: Splashscreen(),
    );
  }
}



//https://github.com/rutujas070/Flutter_QuizApp/tree/main/quizapp_withapi