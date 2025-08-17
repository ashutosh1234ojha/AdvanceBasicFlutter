import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  ResultsScreen({super.key, required this.answers});

  List<String> answers;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You answered 10 out of 12 questions correctly"),

            SizedBox(height: 30),

            Text("You answered 10 out of 12 questions correctly"),

            SizedBox(height: 30),

            TextButton(onPressed: () => {}, child: Text("Restart quiz")),
          ],
        ),
      ),
    );
  }
}
