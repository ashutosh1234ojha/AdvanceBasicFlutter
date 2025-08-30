import 'package:expense_trakcer/models/expense.dart';
import 'package:expense_trakcer/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expense,
    required this.removeExpense,
  });

  final List<Expense> expense;
  final void Function(Expense expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder:
          (ctx, index) => Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error,
              margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal,
              ),
            ),

            key: ValueKey(expense[index]),
            onDismissed: (direction) {
              removeExpense(expense[index]);
            },
            child: ExpenseItem(expense[index]),
          ),
    );
  }
}
