import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.addexp, {super.key});
  final void Function(Expense exp) addexp;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void savingExpense() {
    final amount = double.tryParse(_amountController.text);
    final amountIsINValid = amount == null || amount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsINValid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Invalid Entries'),
              content: const Text("Please make sure all entries were valid."),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Okay'))
              ],
            );
          });
      return;
    }
    widget.addexp(Expense(
        title: _titleController.text,
        amount: amount,
        date: _selectedDate!,
        catigory: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 212, 201, 233),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              maxLength: 10,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(label: Text("Title")),
            ),
            const SizedBox(
              height: 1,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        label: Text("Amount"),
                        prefix: Icon(Icons.currency_rupee)),
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text((_selectedDate == null)
                        ? "Not Selected"
                        : formatter.format(_selectedDate!)),
                    const SizedBox(width: 1),
                    IconButton(
                        onPressed: () async {
                          final pickedData = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 1,
                                  DateTime.now().month, DateTime.now().day),
                              lastDate: DateTime.now());
                          setState(() {
                            _selectedDate = pickedData;
                          });
                        },
                        icon: const Icon(Icons.calendar_month))
                  ],
                ))
              ],
            ),
            Row(children: [
              const SizedBox(
                width: 10,
              ),
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase())))
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
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Text("cancil")),
              const SizedBox(width: 5),
              ElevatedButton(
                  onPressed: savingExpense,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Text("Add"))
            ])
          ],
        ),
      ),
    );
  }
}
