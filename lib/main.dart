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
    http.Response response = await http.get("api.coincap.io/v2/rates/bitcoin");
    var results = jsonDecode(response.body);

    setState(() {
      this.rank;
      this.coinSymbol = results['data']['symbol'];
      this.name;
      this.priceUsd;
    });
  }

  @override
  void initState() {
    super.initState();
    this.getCrypto();
  }

//temp != null ? temp.toString() + "\u00B0" : "Loading",
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text('Crypto Ticker')),
          body: Column(
            children: <Widget>[
              Text(coinSymbol != null ? coinSymbol.toString() : "na"),
            ],
          )),
    );
  }
}
