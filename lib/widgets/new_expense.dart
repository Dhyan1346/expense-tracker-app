import 'dart:io';

import 'package:expance_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For DateFormat

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  // Date Formatter
  final DateFormat formatter = DateFormat.yMd();

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _showDialog(){
    if(Platform.isAndroid)
    showCupertinoDialog(


        context: context, builder: (ctx)=>CupertinoAlertDialog(
      title: const Text('Invalid input'),
      content: const Text('Please make sure a valid title, amount, date, and category are entered.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Okay'),
        ),],
    )
    );
    else{
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Invalid input'),
            content: const Text('Please make sure a valid title, amount, date, and category are entered.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Okay'),
              ),
            ],
          ));
    }


  }


  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final isAmountValid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty || isAmountValid || _selectedDate == null) {
      _showDialog();


      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboard + 16),
              child: Column(
                children: [
                  // Title and Amount in a row if in landscape mode
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 30,
                            decoration: const InputDecoration(label: Text('Title')),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            maxLength: 30,
                            decoration: const InputDecoration(
                              prefixText: '\$',
                              label: Text('Amount'),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        TextField(
                          controller: _titleController,
                          maxLength: 30,
                          decoration: const InputDecoration(label: Text('Title')),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          maxLength: 30,
                          decoration: const InputDecoration(
                            prefixText: '\$',
                            label: Text('Amount'),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  // Category and Date Picker in a row
                  Row(
                    children: [
                      DropdownButton<Category>(
                        value: _selectedCategory,
                        items: Category.values
                            .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toString()),
                        ))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(_selectedDate == null
                                ? 'No date selected'
                                : formatter.format(_selectedDate!)),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Action buttons (Cancel, Save)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
