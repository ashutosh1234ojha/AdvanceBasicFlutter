import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  AnswerButton({super.key, required this.answerText, required this.onTap});

  final String answerText;
  void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {onTap(answerText)},
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 33, 1, 95),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      ),

      child: Text(answerText, textAlign: TextAlign.center),
    );
  }
}
