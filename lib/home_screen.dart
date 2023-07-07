import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/expense_list.dart';
import 'package:expense_tracker/new_expense.dart';
import 'package:expense_tracker/chart/chart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Expense> expence = [];

  void add(Expense exp) {
    setState(() {
      expence.add(exp);
    });
  }

  void remove(Expense expense) {
    final indexOfExpense = expence.indexOf(expense);
    setState(() {
      expence.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      content: const Text("Expense Deleted"),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              expence.insert(indexOfExpense, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text(
        "No Expences to Show,Try to add some",
        style: TextStyle(fontSize: 18),
      ),
    );
    if (expence.isNotEmpty) {
      mainContent = Column(
        children: [
          Chart(expenses: expence),
          Expanded(child: ExpenseList(expence, remove))
        ],
      );
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 97, 63, 155),
          foregroundColor: Colors.white,
          title: const Text(
            "Expencse Tracker",
            textAlign: TextAlign.left,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (ctx) {
                        return NewExpense(add);
                      });
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: mainContent);
  }
}
