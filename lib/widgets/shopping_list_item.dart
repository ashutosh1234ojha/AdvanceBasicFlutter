import 'package:flutter/material.dart';

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(height: 40, width: 40, color: Colors.amber),
        ),

        Expanded(
          child: Container(
            color: Colors.green,
            child: Text(
              "Maasdfsfasfasfdasdf asfasdfasasdfsdfdsf  sdfsdfds silk",
            ),
          ),
        ),

        Padding(padding: const EdgeInsets.all(16.0), child: Text("1")),
      ],
    );
  }
}
