import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: summaryData
              .map(
                (summary) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    FilledButton(
                      onPressed: () {},
                      child: Text(
                        ((summary["question_index"] as int) + 1).toString(),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            summary["question"] as String,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            summary["answer"] as String,
                            style: GoogleFonts.inter(
                              color: const Color.fromARGB(255, 47, 9, 85),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            summary["selected_option"] as String,
                            style: GoogleFonts.inter(
                              color: summary["answer"] ==
                                      summary["selected_option"]
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
