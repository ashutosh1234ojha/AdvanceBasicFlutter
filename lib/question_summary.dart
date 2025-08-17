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
                bool isCorrect =
                    data["user_answer"] ==
                    data["correct_answer"]; // your condition

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40, // size of the circle
                      height: 40,
                      decoration: BoxDecoration(
                        color:
                            isCorrect
                                ? Colors.green
                                : Colors.pinkAccent, // circle color
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          ((data['question_index'] as int) + 1).toString(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['question'] as String,
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 5),
                          Text(
                            data['user_answer'] as String,
                            style: TextStyle(color: Colors.blue),
                          ),
                          Text(
                            data['correct_answer'] as String,
                            style: TextStyle(color: Colors.blueGrey),
                          ),
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
