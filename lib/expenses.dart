//To display all the expenses on screen to user

//For creating main user interface

//We should have two classes
//pne widget class & one state class

import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/expenses_list/new_expense.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

import 'package:expense_tracker/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  //constructor function
  const Expenses({super.key});

 
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

//State is builtin class, we should mention which widget it is
class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      //DateTime is also a class not just datatype
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 16.99,
      //DateTime is also a class not just datatype
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay(){
    //Show builtin UI elements
    //This will add new dynamic UI element
    //context : is input to build method, Flutter automatically adds context
    //context: is An object full of metadata related to widget & its position in overall widget tree
    //builder should be a widget

    //Modal bottom sheet is a small sheet popup that greys background 
       showModalBottomSheet(
        isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

void _addExpense(Expense expense)
{
  setState((){
      _registeredExpenses.add(expense);
  });
}

void _removeExpense(Expense expense)
{

  final expsenseIndex=_registeredExpenses.indexOf(expense);
  setState(() {
    _registeredExpenses.remove(expense);
  });
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    //A Snackbar in Flutter is a widget that provides a brief message at the bottom of the screen.
    // It is typically used to inform users about an action that has occurred, such as a message being deleted or an item being added to a cart.
    // The Snackbar can also include an action button, such as "Undo" or "Retry", allowing users to respond to the message.
    SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Expense Deleted.'),
      action: SnackBarAction(
        label: 'Undo', 
        onPressed: (){
          setState(() {
            _registeredExpenses.insert(expsenseIndex, expense);
          });
        }
        
        )
      
      ),
  );
 
}


  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),

    );

  if(_registeredExpenses.isNotEmpty)
  {
mainContent= ExpensesList(expenses: _registeredExpenses, onRemoveExpense: _removeExpense,);
         
  }

    return Scaffold(
      //AppBar being used to add the top bar
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            //when add button is pressed
            onPressed: _openAddExpenseOverlay, 
          icon: Icon(Icons.add)
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child:  mainContent,
          ),
        ],
      ),
    );
  }
}
