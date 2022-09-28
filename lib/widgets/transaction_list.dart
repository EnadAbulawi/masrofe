import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transcation.dart';



class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx,{super.key, });



  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *0.7,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 19,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$ ${transactions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      textAlign: TextAlign.center,
                      style : TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 18
                      ),
                      transactions[index].title,
                      
                    ),
                    
                    subtitle: Text(
                       style : TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 15
                      ),
                        textAlign: TextAlign.center,
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                      iconSize: 30,
                      icon: Icon(Icons.delete),
                     color: Color.fromARGB(255, 255, 17, 0),
                      onPressed: () => deleteTx(transactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
