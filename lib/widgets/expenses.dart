import 'package:expense_trakcer/widgets/expense_list/expenses_list.dart';
import 'package:expense_trakcer/models/expense.dart';
import 'package:expense_trakcer/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expenses> {
  final List<Expense> registeredExpenses = [
    Expense(
      title: "Flutter course",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Cinema",
      amount: 15.69,
      date: DateTime.now(),
      category: Category.lesiure,
    ),
    Expense(
      title: "Cinema",
      amount: 15.69,
      date: DateTime.now(),
      category: Category.lesiure,
    ),
    Expense(
      title: "Cinema",
      amount: 15.69,
      date: DateTime.now(),
      category: Category.lesiure,
    ),

    Expense(
      title: "Cinema",
      amount: 15.69,
      date: DateTime.now(),
      category: Category.lesiure,
    ),
    Expense(
      title: "Cinema",
      amount: 15.69,
      date: DateTime.now(),
      category: Category.lesiure,
    ),
    Expense(
      title: "Cinema",
      amount: 15.69,
      date: DateTime.now(),
      category: Category.lesiure,
    ),
  ];

  final List<Expense> _registeredExpenses = [];

  void _addListData(Expense item) {
    setState(() {
      _registeredExpenses.add(item);
    });
  }

  void _removeListData(Expense item) {
    setState(() {
      _registeredExpenses.remove(item);
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(addListData: _addListData),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Expense Tracker"),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          Text("chart"),
          Expanded(
            child: ExpensesList(
              expense: _registeredExpenses,
              removeExpense: _removeListData,
            ),
          ),
        ],
      ),
    );
  }
}
