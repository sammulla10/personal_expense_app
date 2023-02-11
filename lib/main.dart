import 'package:flutter/material.dart';
import 'package:personal_expense_app/widgets/chart.dart';
import 'package:personal_expense_app/widgets/transaction_list.dart';
import 'models/transaction.dart';
import 'widgets/new_transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        errorColor: Colors.red[900],
        fontFamily: 'OpenSans',
        textTheme: TextTheme(
          titleMedium: TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
              fontSize: 20),
          titleSmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titlecontroller = TextEditingController();
  final amountcontroller = TextEditingController();

  final List<Transaction> _usertransaction = [
    // Transaction(
    //   id: 't1',
    //   title: 'Shoes',
    //   amount: 500,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Snacks',
    //   amount: 150,
    //   date: DateTime.now(),
    // )
  ];

  void _deleteTransaction(String id) {
    setState(() {
      _usertransaction.removeWhere((tx) => tx.id == id);
    });
  }

  void _addNewTransaction(
      String txtitle, double txamount, DateTime chosenDate) {
    final newTx = Transaction(
        title: txtitle,
        amount: txamount,
        date: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      _usertransaction.add(newTx);
    });
  }

  void _startAddNewTx(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => _startAddNewTx(context),
              icon: Icon(Icons.add),
            )
          ],
          toolbarHeight: 70,
          title: Text(
            'Personal Expenses',
            // style: TextStyle(fontFamily: 'Opensans'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: IconButton(
              onPressed: () => _startAddNewTx(context),
              icon: Icon(Icons.add),
            )),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Chart(_usertransaction),
              TransactionList(_usertransaction, _deleteTransaction)
            ],
          ),
        ),
      ),
    );
  }
}
