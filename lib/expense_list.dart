import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(this.expences, this.removeThis, {super.key});
  final List<Expense> expences;
  final void Function(Expense expense) removeThis;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expences.length,
        itemBuilder: (context, index) {
          return Dismissible(
            onDismissed: (direction) => removeThis(expences[index]),
            key: ValueKey(expences[index]),
            child: Card(
                color: const Color.fromARGB(255, 227, 221, 237),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20),
                            child: Text(
                              expences[index].title,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.currency_rupee),
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(child: Text('${expences[index].amount}')),
                          const Spacer(),
                          Icon(categoryIcons[expences[index].catigory]),
                          const SizedBox(width: 3),
                          Text('${expences[index].formattedDate}')
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                )),
          );
        });
  }
}
