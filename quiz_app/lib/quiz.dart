import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz_questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/results_screen.dart';
import 'package:quiz_app/welcome_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  var activeScreen = "welcome_screen";
  List<String> selectedOptions = [];

  void switchScreen() {
    setState(() {
      activeScreen = "questions_screen";
    });
  }

  void chooseOption(String option) {
    selectedOptions.add(option);

    if (selectedOptions.length == questions.length) {
      setState(() {
        activeScreen = "results_screen";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget? screenWidget = WelcomeScreen(switchScreen);

    if (activeScreen == "questions_screen") {
      screenWidget = QuestionsScreen(onOptionSelected: chooseOption);
    }

    if (activeScreen == "results_screen") {
      screenWidget = ResultsScreen(chosenOptions: selectedOptions);
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: screenWidget,
      ),
    );
  }
}
