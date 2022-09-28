import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final double enteredAmount = double.tryParse(_amountController.text) ?? 0;

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });

    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       height:MediaQuery.of(context).size.height *0.45,
      decoration: BoxDecoration(
       
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(30.0),
              topRight: const Radius.circular(30.0))),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
               prefixIcon: Icon(Icons.title),
              hintText: 'ادخل اسم الشيء اللذي قمت بشرائه',
                labelText: 'العنوان', border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(25),
                )),
            textAlign: TextAlign.right,
            // decoration: InputDecoration(labelText: 'العنوان'),
            controller: _titleController,
            keyboardType: TextInputType.text,
            onSubmitted: (_) => _submitData(),
            // onChanged: (val) {
            //   titleInput = val;
            // },
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            autofocus: true,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
            prefixIcon: Icon(Icons.price_change_rounded),
              hintText: 'ادخل سعر الشيء اللذي قمت بشرائه',
              
                labelText: 'السعر', border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(25),
                   
                )),
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitData(),
            // onChanged: (val) => amountInput = val,
          ),
          SizedBox(
            height: 70,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Chosen!'
                        : 'تاريخ اليوم : ${DateFormat.yMd().format(_selectedDate)}',
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(TextStyle(
                    color: Theme.of(context).primaryColor,
                  ))),
                  child: Text(
                    'اختر التاريخ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _presentDatePicker,
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width *.900,
            height:  MediaQuery.of(context).size.height *0.08,
            child: ElevatedButton(
              child: Text('اضافة'),
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(TextStyle(
                    color: Theme.of(context).textTheme.button!.color,
                  )),
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColor,
                  )),
              onPressed: _submitData,
            ),
          ),
        ],
      ),
    );
  }
}
