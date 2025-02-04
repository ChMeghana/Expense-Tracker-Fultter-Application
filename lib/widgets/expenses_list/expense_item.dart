//Contians class, widget class to display
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    //Card widget is used to create a card
    //It will elevate the widget
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 60,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title, 
              style: Theme.of(context).textTheme.titleLarge ,),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                //rounds hte decimal places //toStringAsFixed(2) is a method in dart
                //{} will indicate that it is a named parameter & claculations need to be done and injected as a variab;e
                //escape character \$
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                //Widget to get all the space between the widgets
               const  Spacer(),
                Row(
                  children: [
                     Icon(categoryIcons[expense.category]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      //here we are accessing getter method, so not using $ symbol
                      expense.formattedDate,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
