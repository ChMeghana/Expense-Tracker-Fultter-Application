import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';


//This file is for adding the new expense

class NewExpense extends StatefulWidget {
  const NewExpense({super.key,required this.onAddExpense});

   final void Function(Expense expense) onAddExpense;


  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // var _enteredTitle = ' ';

  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }

  //When widget is not being used anymore the controller should be deleted
  //We have to specify it to flutter
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  //to delete the controller
  @override
  void dispose() {
    
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    //Future, flutter thinks about future object

    final now = DateTime.now();

    // showDatePicker(
    //     context: context,
    //     initialDate: now,
    //     firstDate: DateTime(now.year - 1, now.month, now.day),
    //     lastDate: now,).then((value){

    //     },);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(now.year - 1, now.month, now.day),
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    //try parse will try to convert stiring to double

    final amountIsInvalid = enteredAmount==null || enteredAmount <= 0;
    if(_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate==null){
      //show error message if invalid input
      showDialog(context: context, builder:  (ctx ) => AlertDialog(
        title: const Text('Invalid Input'),
        content: const Text('Please make sure a valid amount title date are entered!'),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(ctx);
             },
             child: const Text('Okay')
             ),
        ],
      ));

      return ;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text , 
        amount: enteredAmount, 
        date: _selectedDate!, 
        category: _selectedCategory,
        
        )
        
      );
      Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Padding(
      padding: EdgeInsets.fromLTRB(16,48,16,16),
      child: Column(
        children: [
          //TextField is Text input element, which allows user to take text input
          TextField(
            // onChanged: _saveTitleInput,
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              label: const Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  // onChanged: _saveTitleInput,
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end, //vertical
                crossAxisAlignment: CrossAxisAlignment.center, //horizantal
                children: [
                  Text(_selectedDate == null
                      ? 'No date Selected'
                      : formatter.format(_selectedDate!)),
                  IconButton(
                    onPressed: _presentDatePicker,
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ))
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              //DropDown
              //items should be list of all values for the dropdowj
              DropdownButton(
                value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
                  const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
