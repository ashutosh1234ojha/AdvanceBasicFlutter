import 'package:expense_trakcer/widgets/chart/chart.dart';
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
  final List<Expense> _registeredExpenses = [];

  void _addListData(Expense item) {
    setState(() {
      _registeredExpenses.add(item);
    });
  }

  void _removeListData(Expense item) {
    final expenseIndex = _registeredExpenses.indexOf(item);
    setState(() {
      _registeredExpenses.remove(item);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text("Expense deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, item);
            });
          },
        ),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(addListData: _addListData),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainComponent = const Center(child: Text("Add items to the list"));
    var width = MediaQuery.of(context).size.width;

    if (_registeredExpenses.isNotEmpty) {
      mainComponent = ExpensesList(
        expense: _registeredExpenses,
        removeExpense: _removeListData,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Expense Tracker"),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: Icon(Icons.add)),
        ],
      ),
      body:
          width < 600
              ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  Expanded(child: mainComponent),
                ],
              )
              : Row(
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(child: mainComponent),
                ],
              ),
    );
  }
}
