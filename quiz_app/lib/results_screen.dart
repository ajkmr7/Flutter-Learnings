import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/models/quiz_questions.dart';
import 'package:quiz_app/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.chosenOptions});

  final List<String> chosenOptions;

  List<Map<String, Object>> get summary {
    final List<Map<String, Object>> summaryData = [];

    for (var i = 0; i < chosenOptions.length; i++) {
      summaryData.add({
        'question_index': i,
        'question': questions[i].question,
        'answer': questions[i].options[0],
        'selected_option': chosenOptions[i],
      });
    }

    return summaryData;
  }

  @override
  Widget build(BuildContext context) {
    var numCorrectlyAnsweredQuestions = summary
        .where((element) => element['answer'] == element['selected_option'])
        .length;
    final numTotalQuestions = questions.length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "You have answered $numCorrectlyAnsweredQuestions out of $numTotalQuestions questions correctly!",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 18,
                )),
            const SizedBox(
              height: 20,
            ),
            QuestionsSummary(
              summary,
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton.icon(
              icon: const Icon(Icons.restart_alt),
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              onPressed: () {},
              label: const Text(
                "Restart Quiz",
              ),
            )
          ],
        ),
      ),
    );
  }
}
