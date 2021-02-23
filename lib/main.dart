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

//temp != null ? temp.toString() + "\u00B0" : "Loading",
  @override
  Widget build(BuildContext context) {
    const PrimaryColor = const Color(0xFF000000);
    return MaterialApp(
        theme: ThemeData(
          primaryColor: PrimaryColor,
        ),
        home: Scaffold(
            //backgroundColor: Colors.black,
            //appBar: AppBar(title: Text('Crypto Ticker')),
            body: SafeArea(
          child: Container(
              width: 600.00,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('images/holly.png'),
                fit: BoxFit.cover,
              )),
              child: Column(
                children: <Widget>[
                  Container(
                    child: new Text(coinSymbol != null
                        ? coinSymbol.toString()
                        : "Loading..."),
                  ),
                  Container(
                    child: Text(name != null ? name.toString() : "Loading..."),
                  ),
                  Container(
                      child:
                          Text(rank != null ? rank.toString() : "Loading...")),
                  Container(
                      child: Text(priceUsd != null
                          ? priceUsd.toString()
                          : "Loading...")),
                ],
              )),
        )));
  }
}
