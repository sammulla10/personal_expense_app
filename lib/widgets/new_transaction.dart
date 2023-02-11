import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _submitData() {
    final enteredTitle = _titlecontroller.text;
    final enteredAmount = double.parse(_amountcontroller.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0|| _selectedDate==null) {
      return;
    }

    widget.addTx(
      _titlecontroller.text,
      double.parse(_amountcontroller.text),
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              keyboardType: TextInputType.name,
              controller: _titlecontroller,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              controller: _amountcontroller,
              keyboardType: TextInputType.phone,
              onSubmitted: (_) => _submitData(),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                      'Picked Date: ${DateFormat().add_yMMMEd().format(_selectedDate)}',
                      style: TextStyle(
                        fontSize: 16,
                      )),
                ),
                TextButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      'Choose Date',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            SizedBox(
              height: 12,
            ),
            TextButton(
              onPressed: () {
                _submitData();
              },
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
