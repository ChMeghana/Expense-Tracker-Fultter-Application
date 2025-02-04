//For creating structure for expense like what category
//It is for storing data 
//So don't need to extend any class
//Uuid package is used for generating unique id
//Can be added into flutter using flutter pub add uuid
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

//Uuid gives us a class, using which can create a object to get new id
//Its a utility object that can be used anywhere
const uuid =  Uuid();

 //Enum is a special type in dart which is used to define a set of constant values
 //Custom data type & values
enum Category{
  food,
  travel,
  leisure,
  work
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {

  //Constructor function
  Expense( {
    //named parameters //  {} means named parameters
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    //: is list initializer which is used to initialize the id or values not received from the constructor
    //v4 is a method in uuid package which assigns a unique id to id
  }) : id = uuid.v4()   ;


  final String id; 
  final String title;
  final double amount;
  //DateTime is data type in dart
  final DateTime date;
  final Category category;

  //Getter function
  //Intl package, here used for formatting date
  String get formattedDate {
    return formatter.format(date);
  }
 
}

class ExpenseBucket{
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  //Additional Constructor or our own cosntructor function
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category) 
  : expenses=allExpenses.where((expense) => expense.category==category).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses{
    double sum=0;

    for(final expense in expenses) {
      sum+= expense.amount;
    }

    return sum;

  }

}
