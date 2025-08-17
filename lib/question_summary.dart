import 'package:advance_basic/data/quesstions.dart';
import 'package:flutter/material.dart';

class QuestionSummary extends StatelessWidget {
  QuestionSummary(this.summaryData, {super.key});

  List<Map<String, Object>> summaryData = [];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children:
              summaryData.map((data) {
                return Row(
                  children: [
                    Text(((data['question_index'] as int) + 1).toString()),
                    Expanded(
                      child: Column(
                        children: [
                          Text(data['question'] as String),
                          SizedBox(height: 5),
                          Text(data['user_answer'] as String),
                          Text(data['correct_answer'] as String),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
        ),
      ),
    );
  }
}
