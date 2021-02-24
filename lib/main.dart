import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var rank;
  var coinSymbol;
  var name;
  var priceUsd;

  Future getCrypto() async {
    http.Response response =
        await http.get("https://api.coincap.io/v2/assets/bitcoin");
    var results = jsonDecode(response.body);

    setState(() {
      this.coinSymbol = results['data']['symbol'];
      this.rank = results['data']['rank'];
      this.name = results['data']['name'];
      this.priceUsd = results['data']['priceUsd'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getCrypto();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cryptocurrency Ticker'),
          centerTitle: true,
          backgroundColor: Colors.blue[700],
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: Text(coinSymbol != null ? coinSymbol : "Loading..."),
              color: Colors.blue[600],
              height: 200.00,
              width: double.infinity,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: null, foregroundColor: Colors.white, child: Text('+')),
      ),
    );

    /*  child: DataTable(
            columns: [
              DataColumn(label: Text('SIGN')),
              DataColumn(label: Text('NAME')),
              DataColumn(label: Text('RANK')),
              DataColumn(label: Text('PRICE')),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text(coinSymbol != null ? coinSymbol : "Loading...")),
                DataCell(Text(name != null ? name : "Loading...")),
                DataCell(Text(rank != null ? rank : "Loading...")),
                DataCell(Text(priceUsd != null ? priceUsd : "Loading...")),
              ])
            ],
          ),*/
  }
}
