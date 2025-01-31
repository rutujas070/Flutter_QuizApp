# Quiz App

## Overview

1️.Splash Screen
Displays a welcome message before transitioning to the quiz.
Uses Future.delayed to navigate automatically after a few seconds.

2️.Quiz Screen (Main Functionality)
Fetches Quiz Data from API
Uses HTTP GET request (http package) to retrieve quiz questions dynamically.
Parses JSON response and maps it to a custom model (Quizapp class).
Handles potential null values to avoid crashes.

3.Question & Answer Display
Dynamically displays questions and four multiple-choice options.
Uses ListView.builder for an optimized and dynamic UI.

4.Correct Answer Validation
Highlights correct and incorrect answers using color changes.
Uses red for incorrect answers and green for correct answers.

5.Score Tracking & Celebration Animation
Increments score when the user selects the correct option.
Shows Lottie animation for correct answers.

6.Explanation for Each Question
Displays detailed explanations for each question after selecting an option.
Controlled via a visibility state toggle.

7.Navigation to Score Screen
Once all questions are answered, navigates to Score Screen.
Uses Navigator.pushReplacement to replace the quiz screen with results.

8.Responsive UI (MediaQuery)
Uses MediaQuery to dynamically adjust:
Button height & width
Font sizes
Padding & spacing for different screen sizes.


## Screenshots


## Video
[Watch the Video]()


## Flutter Version
```
Flutter 3.22.3
Dart 3.4.4 
```

## Dependencies

```
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.2.1
  http: ^1.3.0
  lottie: ^3.1.3
```