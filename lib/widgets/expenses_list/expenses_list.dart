import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

//Keep Track of list of expenses
//This class contains all expenses added
class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    //Column is not good for long list of items
    //Beacause it will load all the items at once
    //Redundant and costly
    //ListView is better for long list of items
    //creates scrollable list of items automatically
    //builder is special constructor function for ListView
    //using this we will create list only when needed
    return ListView.builder(
      itemCount: expenses.length,
      //itemBuilder is a function which will be called for each item
      //it will return a widget
      //It wil create a shadow of widget

      //Dismissable to create dismissable items/widgets when swiped left or right
      //Dismissibile needs key
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direction) {
           onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
