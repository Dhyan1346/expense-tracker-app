import 'package:expance_tracker/chart.dart';
import 'package:expance_tracker/widgets/expenses_list.dart';
import 'package:expance_tracker/models/expense.dart';
import 'package:expance_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(title: 'Flutter', amount: 19.90, date: DateTime.now(), category: Category.work),
    Expense(title: 'Cinema', amount: 15.90, date: DateTime.now(), category: Category.leisure),
  ];

  void _openAddExpensesOverlay() {

    showModalBottomSheet(
      useSafeArea:true,
      isScrollControlled: true,
      context: context,
      builder: (context) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense deleted."),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width= MediaQuery.of(context).size.width;
    // final height=MediaQuery.of(context).size.height;
    Widget mainContent = const Center(
      child: Text("No expenses found. Start adding some!"),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpensesOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body:  width <600 ?Column(
        children: [
          Chart(expenses: _registeredExpenses),

          Expanded(child: mainContent),
        ],
      ): Expanded(
        child: Row(
          children: [
            Expanded(child: Chart(expenses: _registeredExpenses)),
        
            Expanded(child: mainContent),
          ],
        ),
      ),
    );
  }
}

