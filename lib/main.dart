// ignore_for_file: prefer_const_declarations, use_key_in_widget_constructors, prefer_const_constructors, prefer_is_empty, unused_element, avoid_print

import 'package:flutter/material.dart';

import 'category_widget.dart';

final String appTitle = "Lista de Despesas";

void main() {
  runApp(ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: appTitle,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
        debugShowCheckedModeBanner: false);
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String title = appTitle;
  int totalRow = 0;

  List<double> costForEachRow = [];

  void _addRow() {
    setState(() {
      totalRow += 1;
      costForEachRow.add(0);
    });
  }

  void _updateTotalCost() {
    setState(() {
      double totalCost = costForEachRow.length > 0
          ? costForEachRow.reduce((value, element) => value + element)
          : 0;

      if (totalCost > 0.0) {
        // ignore: unnecessary_brace_in_string_interps
        title = "Valor Total: \$R${totalCost}";
      } else {
        title = appTitle;
      }
    });
  }

  void _updateCostForEachRow(int rowNum, double newVal) {
    // ignore: unnecessary_brace_in_string_interps
    print("Row ${rowNum} - newVal ${newVal}");
    setState(() {
      if (costForEachRow.length > rowNum) {
        costForEachRow[rowNum] = newVal;
      }
    });

    _updateTotalCost();
  }

  void _deleteLastRow() {
    setState(() {
      int newTotalRow = totalRow - 1;
      totalRow = newTotalRow < 0 ? 0 : newTotalRow;
      if (costForEachRow.isNotEmpty) {
        costForEachRow.removeLast();
      }
    });

    _updateTotalCost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            for (int i = 0; i < totalRow; ++i)
              CategoryWidget(
                rowNumber: i,
                callback: _updateCostForEachRow,
              ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(title),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addRow,
        label: Text('Adicionar'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.lightBlueAccent,
      ),
    );
  }
}
