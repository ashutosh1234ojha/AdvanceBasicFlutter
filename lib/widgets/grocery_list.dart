import 'package:expense_trakcer/data/dummy_items.dart';
import 'package:flutter/material.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Heading")),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(groceryItems[index].name),

            leading:
                Container(
                  width: 24,
                  height: 24,
                  color: groceryItems[index].category.color,
                )!,
            trailing: Text(groceryItems[index].quantity.toString()),
          );
        },
      ),
    );
  }
}
