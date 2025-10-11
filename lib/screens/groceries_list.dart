import 'package:expense_trakcer/widgets/shopping_list_item.dart';
import 'package:flutter/material.dart';

class GroceriesListScreen extends StatelessWidget {
  GroceriesListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grocery")),
      body: Column(children: [ShoppingListItem()]),
    );
  }
}
