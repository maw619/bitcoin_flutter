import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var formPrice;
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
      var poop = this.priceUsd = results['data']['priceUsd'];
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
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Cryptocurrency Ticker'),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: coinSymbol != null
                  ? getCurrencyIcon(coinSymbol.toString())
                  : "Loading...",
              color: Colors.black,
              height: 200.00,
              width: double.infinity,
            ),
            Container(
              child: priceUsd != null
                  ? Center(
                      child: Text(priceUsd,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.00,
                          )))
                  : "Loading...",
              color: Colors.black,
              height: 200.00,
              width: double.infinity,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: null,
            foregroundColor: Colors.white,
            child: Icon(FontAwesomeIcons.plus)),
      ),
    );
  }

  Icon getCurrencyIcon(String sym) {
    Icon icon;

    if (sym.contains('BTC')) {
      icon = Icon(
        FontAwesomeIcons.bitcoin,
        color: Colors.amber[600],
        size: 100.0,
      );
    } else {
      icon = Icon(FontAwesomeIcons.questionCircle);
    }

    return icon;
  }
}
