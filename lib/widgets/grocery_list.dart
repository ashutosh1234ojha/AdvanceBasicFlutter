import 'dart:convert';

import 'package:expense_trakcer/data/categories.dart';
import 'package:expense_trakcer/data/dummy_items.dart';
import 'package:expense_trakcer/models/categories.dart';
import 'package:expense_trakcer/models/grocery_item.dart';
import 'package:expense_trakcer/widgets/new_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItem = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadItem();
  }

  void _loadItem() async {
    final url = Uri.https(
      'flutterapp-1a703-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );

    final response = await http.get(url);
    final Map<String, dynamic> listData = json.decode(response.body);

    final List<GroceryItem> _loadedItem = [];
    for (final item in listData.entries) {
      final category =
          categories.entries
              .firstWhere(
                (catItem) => catItem.value.title == item.value['category'],
              )
              .value;
      _loadedItem.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }
    setState(() {
      _groceryItem = _loadedItem;
    });
  }

  void _addItem() async {
    await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (ctx) => NewItem()));

    _loadItem();
  }

  void _removedGroceryItem(GroceryItem item) {
    setState(() {
      _groceryItem.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(child: Text("No item added"));
    if (_groceryItem.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItem.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            onDismissed:
                (direction) => {_removedGroceryItem(_groceryItem[index])},
            key: ValueKey(_groceryItem[index].id),
            child: ListTile(
              title: Text(_groceryItem[index].name),

              leading: Container(
                width: 24,
                height: 24,
                color: _groceryItem[index].category.color,
              ),
              trailing: Text(_groceryItem[index].quantity.toString()),
            ),
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Heading"),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),

      body: content,
    );
  }
}
