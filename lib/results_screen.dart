import 'package:advance_basic/data/quesstions.dart';
import 'package:advance_basic/question_summary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  ResultsScreen({super.key, required this.choosenAnswers});

  final List<String> choosenAnswers;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (int i = 0; i < choosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': choosenAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final noOfTotalQuestion = questions.length;
    final noOfTotalCorrectAnswer =
        summaryData.where((data) {
          return data['user_answer'] == data['correct_answer'];
        }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You answered $noOfTotalCorrectAnswer out of $noOfTotalQuestion questions correctly!",
              style: TextStyle(color: Colors.yellow),
            ),

            SizedBox(height: 30),

            QuestionSummary(summaryData),
            SizedBox(height: 30),

            TextButton(
              onPressed: () => {},
              child: Text(
                "Restart quiz",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
